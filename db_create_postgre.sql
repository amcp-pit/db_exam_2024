-- CREATE database vector_modeling;


-- Table user
CREATE TABLE IF NOT EXISTS public.user (
    user_id INT PRIMARY KEY,
    username VARCHAR(128) NOT NULL
);


-- Table model
CREATE TABLE IF NOT EXISTS public.model (
    model_id INT PRIMARY KEY,
    creator_id INT,
    last_editor_id INT,
    last_update_time TIMESTAMP,

    FOREIGN KEY (creator_id) REFERENCES "user"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (last_editor_id) REFERENCES "user"(user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- Table access_list
CREATE TABLE IF NOT EXISTS public.access_list (
    user_id INT,
    model_id INT,
    read_permission BOOLEAN,
    write_permission BOOLEAN,

    PRIMARY KEY (user_id, model_id),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (model_id) REFERENCES model(model_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table plane
CREATE TABLE IF NOT EXISTS public.plane (
    plane_id INT PRIMARY KEY,
    model_id INT,
    point POINT,
    vector1 POINT,
    vector2 POINT,

    FOREIGN KEY (model_id) REFERENCES model(model_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table sketch
CREATE TABLE IF NOT EXISTS public.sketch (
    sketch_id INT PRIMARY KEY,
    model_id INT,
    plane_id INT,

    FOREIGN KEY (model_id) REFERENCES model(model_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (plane_id) REFERENCES plane(plane_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table entity
CREATE TABLE IF NOT EXISTS public.entity (
    entity_id INT NOT NULL PRIMARY KEY,
    sketch_id INT NOT NULL,

    FOREIGN KEY (sketch_id) REFERENCES sketch(sketch_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table param
CREATE TABLE IF NOT EXISTS public.param  (
    param_id INT NOT NULL PRIMARY KEY,
    value  DOUBLE PRECISION NOT NULL
);


-- Table object_type 
CREATE TABLE IF NOT EXISTS public.object_type (
    object_type_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    free_degree INT NOT NULL
);


-- Table object
CREATE TABLE IF NOT EXISTS public.object  (
    object_id INT NOT NULL PRIMARY KEY,
    object_type_id INT NOT NULL,
    parent_id INT,
    name VARCHAR(128),

    FOREIGN KEY (object_type_id) REFERENCES object_type(object_type_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (object_id) REFERENCES entity(entity_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES "object"(object_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table object_param
CREATE TABLE IF NOT EXISTS public.object_param  (
    object_id INT NOT NULL,
    param_id INT NOT NULL,

    PRIMARY KEY (object_id, param_id),
    FOREIGN KEY (param_id) REFERENCES "param"(param_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (object_id) REFERENCES "object"(object_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table constraint_type
CREATE TABLE IF NOT EXISTS public.constraint_type  (
    constraint_type_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    is_parametric BOOLEAN NOT NULL
);


-- Table constraint
CREATE TABLE IF NOT EXISTS public.constraint (
    constraint_id INT NOT NULL PRIMARY KEY,
    constraint_type_id INT NOT NULL,

    FOREIGN KEY (constraint_type_id) REFERENCES constraint_type(constraint_type_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (constraint_id) REFERENCES entity(entity_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table constraint_info
CREATE TABLE IF NOT EXISTS public.constraint_info (
    constraint_id INT NOT NULL,
    object_id  INT NOT NULL,

    PRIMARY KEY (constraint_id, object_id),
    FOREIGN KEY (constraint_id) REFERENCES "constraint"(constraint_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (object_id) REFERENCES "object"(object_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table constraint_param 
CREATE TABLE IF NOT EXISTS public.constraint_param  (
    constraint_id INT NOT NULL,
    param_id INT NOT NULL,

    PRIMARY KEY (constraint_id, param_id),
    FOREIGN KEY (constraint_id) REFERENCES "constraint"(constraint_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (param_id) REFERENCES "param"(param_id) ON DELETE CASCADE ON UPDATE CASCADE
);
