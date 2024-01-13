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
	read_access boolean,
	write_access boolean,
	PRIMARY KEY (idaccess),
	foreign key (user_) references public.user ( iduser ) ON DELETE CASCADE ON UPDATE cascade,
	foreign key (model_) references model ( idmodel ) ON DELETE CASCADE ON UPDATE cascade);


create table public.plane (
	idplane int not null,
	xpoint DOUBLE PRECISION NOT null,
	ypoint DOUBLE PRECISION NOT null,
	zpoint DOUBLE PRECISION NOT null,
	e1x1 DOUBLE PRECISION NOT null,
	e1y1 DOUBLE PRECISION NOT null,
	e1z1 DOUBLE PRECISION NOT null,
	e2x1 DOUBLE PRECISION NOT null,
	e2y1 DOUBLE PRECISION NOT null,
	e2z1 DOUBLE PRECISION NOT null,
	e1x2 DOUBLE PRECISION NOT null,
	e1y2 DOUBLE PRECISION NOT null,
	e1z2 DOUBLE PRECISION NOT null,
	e2x2 DOUBLE PRECISION NOT null,
	e2y2 DOUBLE PRECISION NOT null,
	e2z2 DOUBLE PRECISION NOT null,
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
  PRIMARY KEY ( identity ));

create table public.point (
	idpoint int not null,
	plane_ int not null,
	PRIMARY KEY ( idpoint ),
	foreign key (plane_) references plane ( idplane ) ON DELETE CASCADE ON UPDATE cascade);

CREATE TABLE public.entityinfo (
	entity_ int not null,
	sketch_ int not null,
	PRIMARY KEY ( entity_, sketch_ ),
	FOREIGN KEY ( entity_ ) REFERENCES  entity  ( identity )  ON DELETE CASCADE ON UPDATE CASCADE,
  	FOREIGN KEY ( sketch_ ) REFERENCES  sketch ( idsketch)  ON DELETE CASCADE ON UPDATE CASCADE);

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
   num int,
  PRIMARY KEY ( idobject ),
  FOREIGN KEY ( objtype ) REFERENCES  objtype  ( idobjtype ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idobject ) REFERENCES  entity  ( identity )  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idparent ) REFERENCES  object  ( idobject )  ON DELETE CASCADE ON UPDATE CASCADE);


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