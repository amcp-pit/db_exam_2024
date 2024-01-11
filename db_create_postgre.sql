CREATE TABLE "user" (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(255) NOT NULL
);

CREATE TABLE "model" (
    ModelID SERIAL PRIMARY KEY,
    CreatedBy INTEGER REFERENCES "user"(UserID),
    LastModifiedBy INTEGER REFERENCES "user"(UserID),
    LastUpdateTime TIMESTAMP,
    CONSTRAINT fk_created_user FOREIGN KEY (CreatedBy) REFERENCES "user"(UserID),
    CONSTRAINT fk_modified_user FOREIGN KEY (LastModifiedBy) REFERENCES "user"(UserID)
);

CREATE TABLE "plane" (
    PlaneID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    Point POINT,
    BasisVector1 POINT,
    BasisVector2 POINT,
    CONSTRAINT fk_plane_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID)
);

CREATE TABLE "sketch" (
    SketchID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    PlaneID INTEGER REFERENCES "plane"(PlaneID),
    CONSTRAINT fk_sketch_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID),
    CONSTRAINT fk_sketch_plane FOREIGN KEY (PlaneID) REFERENCES "plane"(PlaneID)
);

CREATE TABLE "param" (
    ParamID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    Value DOUBLE PRECISION,
    CONSTRAINT fk_param_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID)
);

CREATE TABLE "entity" (
    EntityID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    ObjectType VARCHAR(255),
    ParentObjectID INTEGER REFERENCES "entity"(EntityID),
    CONSTRAINT fk_entity_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID),
    CONSTRAINT fk_entity_parent FOREIGN KEY (ParentObjectID) REFERENCES "entity"(EntityID)
);

CREATE TABLE "object" (
    ObjectID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    ObjectType VARCHAR(255),
    ParentObjectID INTEGER REFERENCES "entity"(EntityID),
    CONSTRAINT fk_object_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID),
    CONSTRAINT fk_object_parent FOREIGN KEY (ParentObjectID) REFERENCES "entity"(EntityID)
);

CREATE TABLE "constraint" (
    ConstraintID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    ConstraintType VARCHAR(255),
    Primitive1ID INTEGER REFERENCES "entity"(EntityID),
    Primitive2ID INTEGER REFERENCES "entity"(EntityID),
    ParameterID INTEGER REFERENCES "param"(ParamID),
    ParameterValue DOUBLE PRECISION,
    CONSTRAINT fk_constraint_model FOREIGN KEY (ModelID) REFERENCES "model"(ModelID),
    CONSTRAINT fk_constraint_primitive1 FOREIGN KEY (Primitive1ID) REFERENCES "entity"(EntityID),
    CONSTRAINT fk_constraint_primitive2 FOREIGN KEY (Primitive2ID) REFERENCES "entity"(EntityID),
    CONSTRAINT fk_constraint_param FOREIGN KEY (ParameterID) REFERENCES "param"(ParamID)
);

CREATE TABLE "access_list" (
    AccessID SERIAL PRIMARY KEY,
    ModelID INTEGER REFERENCES "model"(ModelID),
    UserID INTEGER REFERENCES "user"(UserID),
    ReadAccess BOOLEAN,
    WriteAccess BOOLEAN,
    CONSTRAINT fk_model_access FOREIGN KEY (ModelID) REFERENCES "model"(ModelID),
    CONSTRAINT fk_user_access FOREIGN KEY (UserID) REFERENCES "user"(UserID)
);
