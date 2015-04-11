
CREATE TABLE IF NOT EXISTS acusers (
idacuser int auto_increment,
login varchar(254) not null,
senha varchar(254) not null,
name varchar(254),
email varchar(254),
state ENUM('active', 'unactive'),
primary key(idacuser)
);

CREATE TABLE IF NOT EXISTS acgroups (
idacgroup int auto_increment,
admin_id int not null,
name varchar(254),
primary key(idacgroup)
);

CREATE TABLE IF NOT EXISTS acgroups_acusers (
idacgroup int not null,
idacuser int not null
	);

CREATE TABLE IF NOT EXISTS privilege_controller (
idprivilege int auto_increment,
modulename varchar(254),
controllername varchar(254),
controlleraction varchar(254),
r boolean,
w boolean,
d boolean,
idacgroup int,
primary key(idprivilege)
);
