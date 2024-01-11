CREATE TABLE user_ (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255)
);

CREATE TABLE model (
    model_id SERIAL PRIMARY KEY,
    creator_id INT,
    last_editor INT,
    last_update TIMESTAMP,
    FOREIGN KEY (creator_id) REFERENCES user_ (user_id),
    FOREIGN KEY (last_editor) REFERENCES user_ (user_id)
);

CREATE TABLE access_list (
    access_id SERIAL PRIMARY KEY,
    model_id INT,
    user_id INT,
    read_access BOOLEAN,
    write_access BOOLEAN,
    FOREIGN KEY (model_id) REFERENCES model (model_id),
    FOREIGN KEY (user_id) REFERENCES user_ (user_id)
);

CREATE TABLE plane (
    plane_id SERIAL PRIMARY KEY,
    model_id INT,
    point POINT,
    basis_vector_1 POINT,
    basis_vector_2 POINT,
    FOREIGN KEY (model_id) REFERENCES model (model_id)
);

CREATE TABLE sketch (
    sketch_id SERIAL PRIMARY KEY,
    model_id INT,
    plane_id INT,
    FOREIGN KEY (model_id) REFERENCES model (model_id),
    FOREIGN KEY (plane_id) REFERENCES plane (plane_id)
);

CREATE TABLE param (
    param_id SERIAL PRIMARY KEY,
    value FLOAT CHECK (value > 0)
);

CREATE TABLE entity (
    entity_id SERIAL PRIMARY KEY,
    sketch_id INT,
    FOREIGN KEY (sketch_id) REFERENCES sketch (sketch_id)
);

CREATE TABLE object_ (
    object_id SERIAL PRIMARY KEY,
    entity_id INT,
    object_type VARCHAR(255),
    parent_id INT,
    num_param INT, -- кол-во ст свободы
    FOREIGN KEY (entity_id) REFERENCES entity (entity_id),
    FOREIGN KEY (parent_id) REFERENCES object_ (object_id)
);

CREATE TABLE constraint_ (
    constraint_id SERIAL PRIMARY KEY,
    param_id INT,
    entity_id INT,
    object_id INT,
    constraint_type VARCHAR(255),
    value FLOAT,
    FOREIGN KEY (entity_id) REFERENCES entity (entity_id),
    FOREIGN KEY (object_id) REFERENCES object_ (object_id),
    FOREIGN KEY (param_id) REFERENCES param (param_id)
);
