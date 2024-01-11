CREATE  TABLE access_type ( 
	accesstypeid         smallint  NOT NULL ,
	name                 varchar(50)  NOT NULL ,
	CONSTRAINT pk_access_type_accesstypeid PRIMARY KEY ( accesstypeid )
 );

CREATE  TABLE constr_type ( 
	consttypeid          integer  NOT NULL ,
	name                 varchar(50)  NOT NULL ,
	CONSTRAINT pk_constr_type_consttypeid PRIMARY KEY ( consttypeid )
 );

CREATE  TABLE object_type ( 
	objtypeid            integer  NOT NULL ,
	name                 varchar(50)  NOT NULL ,
	degree_freedom       integer  NOT NULL ,
	CONSTRAINT pk_object_type_objtypeid PRIMARY KEY ( objtypeid )
 );

CREATE  TABLE param ( 
	paramid              integer  NOT NULL ,
	"value"              double precision  NOT NULL ,
	CONSTRAINT pk_param_paramid PRIMARY KEY ( paramid )
 );

CREATE  TABLE plane ( 
	planeid              integer  NOT NULL ,
	x0                   double precision  NOT NULL ,
	y0                   double precision  NOT NULL ,
	z0                   double precision  NOT NULL ,
	ex                   double precision  NOT NULL ,
	ey                   double precision  NOT NULL ,
	ez                   double precision  NOT NULL ,
	CONSTRAINT pk_plane_planeid PRIMARY KEY ( planeid )
 );

ALTER TABLE plane ADD CONSTRAINT cns_plane CHECK ( x0 != 0 and y0 != 0 and z0 != 0 );

CREATE  TABLE "user" ( 
	userid               integer  NOT NULL ,
	name                 varchar(100)  NOT NULL ,
	CONSTRAINT pk_tbl_userid PRIMARY KEY ( userid )
 );

COMMENT ON TABLE "user" IS 'users';

CREATE  TABLE model ( 
	modelid              integer  NOT NULL ,
	userid_own           integer   ,
	userid_modify        integer   ,
	date_modify          timestamp DEFAULT current_timestamp NOT NULL ,
	CONSTRAINT pk_model_modelid PRIMARY KEY ( modelid ),
	CONSTRAINT fk_model_user FOREIGN KEY ( userid_own ) REFERENCES "user"( userid )   ,
	CONSTRAINT fk_model_user_0 FOREIGN KEY ( userid_modify ) REFERENCES "user"( userid )   
 );

CREATE  TABLE sketch ( 
	sketchid             integer  NOT NULL ,
	modelid              integer  NOT NULL ,
	planeid              integer  NOT NULL ,
	CONSTRAINT pk_sketch_sketchid PRIMARY KEY ( sketchid ),
	CONSTRAINT fk_sketch_model FOREIGN KEY ( modelid ) REFERENCES model( modelid )   ,
	CONSTRAINT fk_sketch_plane FOREIGN KEY ( planeid ) REFERENCES plane( planeid )   
 );

CREATE  TABLE access_list ( 
	accessid             serial  NOT NULL ,
	userid               integer  NOT NULL ,
	modelid              integer  NOT NULL ,
	access_type          smallint  NOT NULL ,
	CONSTRAINT pk_access_list_accessid PRIMARY KEY ( accessid ),
	CONSTRAINT fk_access_list_user FOREIGN KEY ( userid ) REFERENCES "user"( userid )   ,
	CONSTRAINT fk_access_list_model FOREIGN KEY ( modelid ) REFERENCES model( modelid )   ,
	CONSTRAINT fk_access_list_access_type FOREIGN KEY ( access_type ) REFERENCES access_type( accesstypeid )   
 );

CREATE  TABLE entity ( 
	entityid             integer  NOT NULL ,
	modelid              integer  NOT NULL ,
	CONSTRAINT pk_entity_entityid PRIMARY KEY ( entityid ),
	CONSTRAINT fk_entity_model FOREIGN KEY ( modelid ) REFERENCES model( modelid )   
 );

CREATE  TABLE "object" ( 
	objectid             integer  NOT NULL ,
	objtypeid            integer  NOT NULL ,
	name                 varchar(50)  NOT NULL ,
	parentid             integer   ,
	CONSTRAINT pk_ob_objectid PRIMARY KEY ( objectid ),
	CONSTRAINT fk_object_object FOREIGN KEY ( parentid ) REFERENCES "object"( objectid )   ,
	CONSTRAINT fk_object_entity FOREIGN KEY ( objectid ) REFERENCES entity( entityid )   ,
	CONSTRAINT fk_object_object_type FOREIGN KEY ( objtypeid ) REFERENCES object_type( objtypeid )   
 );

CREATE  TABLE objparam ( 
	objparamid           serial  NOT NULL ,
	objectid             integer  NOT NULL ,
	paramid              integer  NOT NULL ,
	CONSTRAINT pk_objparam_objparamid PRIMARY KEY ( objparamid ),
	CONSTRAINT fk_objparam_object FOREIGN KEY ( objectid ) REFERENCES "object"( objectid )   ,
	CONSTRAINT fk_objparam_param FOREIGN KEY ( paramid ) REFERENCES param( paramid )   
 );

CREATE  TABLE "constraint" ( 
	constrainid          integer  NOT NULL ,
	consttypeid          integer  NOT NULL ,
	CONSTRAINT pk_constra_constrainid PRIMARY KEY ( constrainid ),
	CONSTRAINT fk_constraint_constr_type FOREIGN KEY ( constrainid ) REFERENCES constr_type( consttypeid )   ,
	CONSTRAINT fk_constraint_entity FOREIGN KEY ( constrainid ) REFERENCES entity( entityid )   
 );

CREATE  TABLE rel_constr_object ( 
	objectid             integer  NOT NULL ,
	constrid             integer  NOT NULL ,
	CONSTRAINT pk_rel_constr_object PRIMARY KEY ( objectid, constrid ),
	CONSTRAINT fk_rel_constr_object_object FOREIGN KEY ( objectid ) REFERENCES "object"( objectid )   ,
	CONSTRAINT fk_rel_constr_object_constraint FOREIGN KEY ( constrid ) REFERENCES "constraint"( constrainid )   
 );

CREATE  TABLE constr_param ( 
	paramid              integer  NOT NULL ,
	constrainid          integer  NOT NULL ,
	CONSTRAINT pk_constr_param PRIMARY KEY ( paramid, constrainid ),
	CONSTRAINT fk_constr_param_param FOREIGN KEY ( paramid ) REFERENCES param( paramid )   ,
	CONSTRAINT fk_constr_param_constraint FOREIGN KEY ( constrainid ) REFERENCES "constraint"( constrainid )   
 );

