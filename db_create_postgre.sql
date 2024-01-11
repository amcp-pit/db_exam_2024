create table public.user (
	iduser int not null,
	username varchar(64),
	PRIMARY KEY (iduser));

create table public.model (
	idmodel int not null,
	usercreate int not null,
	last_user_update int not null,
	updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (idmodel),
	foreign key ( usercreate ) references PUBLIC.user ( iduser ) ON DELETE CASCADE ON UPDATE cascade,
	foreign key ( last_user_update ) references PUBLIC.user ( iduser ) ON DELETE CASCADE ON UPDATE cascade);

create table public.access_list (
	idaccess int not null,
	user_ int not null,
	model_ int not null,
	accesstype varchar(16),
	PRIMARY KEY (idaccess),
	foreign key (user_) references public.user ( iduser ) ON DELETE CASCADE ON UPDATE cascade,
	foreign key (model_) references model ( idmodel ) ON DELETE CASCADE ON UPDATE cascade);

create table public.plane (
	idplane int not null,
	xpoint DOUBLE PRECISION NOT null,
	ypoint DOUBLE PRECISION NOT null,
	e1x DOUBLE PRECISION NOT null,
	e1y DOUBLE PRECISION NOT null,
	e2x DOUBLE PRECISION NOT null,
	e2y DOUBLE PRECISION NOT null,
	model_ int not null,
	PRIMARY KEY (idplane),
	foreign key (model_) references model ( idmodel ) ON DELETE CASCADE ON UPDATE cascade);

create table public.sketch (
	idsketch int not null,
	plane_ int not null,
	PRIMARY KEY (idsketch),
	foreign key (plane_) references plane ( idplane ) ON DELETE CASCADE ON UPDATE cascade);

CREATE TABLE public.entity (
   identity  int NOT NULL,
   sketch_  INT NOT NULL,
  PRIMARY KEY ( identity ),
  FOREIGN KEY ( sketch_ ) REFERENCES  sketch ( idsketch ) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE  public.param  (
   idparam  int NOT NULL,
   value  DOUBLE PRECISION NOT NULL,   
  PRIMARY KEY ( idparam ) );

CREATE TABLE  public.objtype  (
   idobjtype  int NOT NULL,
   name  VARCHAR(45) NOT NULL,
   freedegree  INT NOT NULL,
  PRIMARY KEY ( idobjtype ));

CREATE TABLE  public.object  (
   idobject  int NOT NULL,
   objtype  SMALLINT NOT NULL,
   idparent int,
   name VARCHAR(45),
  PRIMARY KEY ( idobject ),
  FOREIGN KEY ( objtype ) REFERENCES  objtype  ( idobjtype ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idobject ) REFERENCES  entity  ( identity )  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idparent ) REFERENCES  object  ( idobject )  ON DELETE CASCADE ON UPDATE CASCADE);
 
 create table public.point (
 	idpoint int not null,
 	x DOUBLE PRECISION NOT null,
 	y DOUBLE PRECISION NOT null,
 	PRIMARY KEY ( idpoint ),
 	FOREIGN KEY ( idpoint ) REFERENCES  object  ( idobject )  ON DELETE CASCADE ON UPDATE CASCADE
 );


CREATE TABLE  public.objparam  (
   idobject  int NOT NULL,
   idparam  int NOT NULL,   
   num  INT NULL,
  PRIMARY KEY ( idobject, idparam ),
  FOREIGN KEY ( idparam ) REFERENCES  param  ( idparam )   ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idobject ) REFERENCES  object  ( idobject ) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE  public.constrtype  (
   idconstrtype  smallint NOT NULL,
   name  VARCHAR(45) not NULL,
   is_parametric  boolean not NULL,
  PRIMARY KEY ( idconstrtype ));


CREATE TABLE  public."constraint"  (
   idconstraint  int NOT NULL,
   constrtype  SMALLint NOT NULL,
  PRIMARY KEY ( idconstraint ),
  FOREIGN KEY ( constrtype ) REFERENCES  constrtype  ( idconstrtype ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idconstraint ) REFERENCES  entity  ( identity ) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE  public.constrinfo  (
   idconstraint  int NOT NULL,
   idobject  int NOT NULL,
  PRIMARY KEY ( idconstraint ,  idobject ),
  FOREIGN KEY ( idconstraint ) REFERENCES  "constraint"  ( idconstraint ) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idobject ) REFERENCES  object  ( idobject ) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE  public.constrparam  (
   idconstraint  int NOT NULL,
   idparam  int NOT NULL,
  PRIMARY KEY ( idconstraint ,  idparam ),
  FOREIGN KEY ( idconstraint ) REFERENCES  "constraint"  ( idconstraint ) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idparam ) REFERENCES  param  ( idparam ) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (1,'Point',2);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (2,'Segment',4);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (3,'Circle',3);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (4,'Arc',5); 

INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (0,'Fixed',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (1,'Equal',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (2,'Vertical',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (3,'Horizontal',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (4,'Distance',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (5,'Angle',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (6,'Parallel',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (7,'Ortho',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (8,'Tangent',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (9,'Coincident',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (10,'Midpoint',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (11,'Collinear',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (12,'Dimension',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (13,'Symmetric',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (14,'Concentric',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (15,'Arcbase',false);