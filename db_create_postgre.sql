-- Создание таблицы Пользователь (User)
CREATE TABLE "User" (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(255) NOT NULL
);

-- Создание таблицы Модель (Model)
CREATE TABLE Model (
    ModelID SERIAL PRIMARY KEY,
    CreatedBy INTEGER REFERENCES "User"(UserID),
    LastModifiedBy INTEGER REFERENCES "User"(UserID),
    LastUpdateTime TIMESTAMP,
    CONSTRAINT fk_created_user FOREIGN KEY (CreatedBy) REFERENCES "User"(UserID),
    CONSTRAINT fk_modified_user FOREIGN KEY (LastModifiedBy) REFERENCES "User"(UserID)
);

-- Создание таблицы Плоскость (Plane)
CREATE TABLE Plane (
    PlaneID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    Point POINT,
    BasisVector1 POINT,
    BasisVector2 POINT,
    CONSTRAINT fk_plane_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID)
);

-- Создание таблицы Чертеж (Sketch)
CREATE TABLE Sketch (
    SketchID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    PlaneID INTEGER REFERENCES Plane(PlaneID),
    CONSTRAINT fk_sketch_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CONSTRAINT fk_sketch_plane FOREIGN KEY (PlaneID) REFERENCES Plane(PlaneID)
);

-- Создание таблицы Параметр (Parameter)
CREATE TABLE Parameter (
    ParamID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    Value DOUBLE PRECISION,
    CONSTRAINT fk_param_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID)
);

-- Создание таблицы Примитив (Entity)
CREATE TABLE Entity (
    EntityID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    ObjectType VARCHAR(255),
    ParentObjectID INTEGER REFERENCES Entity(EntityID),
    CONSTRAINT fk_entity_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CONSTRAINT fk_entity_parent FOREIGN KEY (ParentObjectID) REFERENCES Entity(EntityID)
);

-- Создание таблицы Объект (Object)
CREATE TABLE Object (
    ObjectID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    ObjectType VARCHAR(255),
    ParentObjectID INTEGER REFERENCES Entity(EntityID),
    CONSTRAINT fk_object_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CONSTRAINT fk_object_parent FOREIGN KEY (ParentObjectID) REFERENCES Entity(EntityID)
);

-- Создание таблицы Ограничение (Constraint)
CREATE TABLE ConstraintTable (
    ConstraintID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    ConstraintType VARCHAR(255),
    Primitive1ID INTEGER REFERENCES Entity(EntityID),
    Primitive2ID INTEGER REFERENCES Entity(EntityID),
    ParameterID INTEGER REFERENCES Parameter(ParamID),
    ParameterValue DOUBLE PRECISION,
    CONSTRAINT fk_constraint_model FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CONSTRAINT fk_constraint_primitive1 FOREIGN KEY (Primitive1ID) REFERENCES Entity(EntityID),
    CONSTRAINT fk_constraint_primitive2 FOREIGN KEY (Primitive2ID) REFERENCES Entity(EntityID),
    CONSTRAINT fk_constraint_param FOREIGN KEY (ParameterID) REFERENCES Parameter(ParamID)
);

-- Создание таблицы Список доступа (AccessList) после всех остальных
CREATE TABLE AccessList (
    AccessID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES Model(ModelID),
    UserID INTEGER REFERENCES "User"(UserID),
    ReadAccess BOOLEAN,
    WriteAccess BOOLEAN,
    CONSTRAINT fk_model_access FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    CONSTRAINT fk_user_access FOREIGN KEY (UserID) REFERENCES "User"(UserID)
);
