create sequence security_group_id_seq;

create table security_groups
( security_group_id number not null
, name varchar2(100) not null
, active_ind varchar2(1) default 'Y'
);

create table security_group_members
( security_group_id number not null
, app_user varchar2(200) not null
, last_login date
, active_ind varchar2(1) default 'Y'
);

create table security_roles
( role_code varchar2(100) not null
, name varchar2(100) not null
, active_ind varchar2(1) default 'Y'
);

create table security_group_roles
( security_group_id number not null
, app_user varchar2(200) not null
, role_code varchar2(100) not null
, active_ind varchar2(1) default 'Y'
);

alter table security_groups add constraint security_group_pk primary key (security_group_id);
alter table security_groups add constraint security_group_name_uk unique (name);
alter table security_groups add constraint security_group_active_ck check (active_ind = 'Y');

alter table security_group_members add constraint security_group_member_pk primary key (security_group_id, app_user);
alter table security_group_members add constraint security_group_member_fk foreign key (security_group_id) references security_groups (security_group_id);
alter table security_group_members add constraint security_group_member_active_ck check (active_ind = 'Y');

alter table security_roles add constraint security_role_pk primary key (role_code);
alter table security_roles add constraint security_role_name_uk unique (name);
alter table security_roles add constraint security_role_active_ck check (active_ind = 'Y');

alter table security_group_roles add constraint security_group_role_pk primary key (security_group_id, app_user, role_code);
alter table security_group_roles add constraint security_group_role_fk foreign key (security_group_id, app_user) references security_group_members (security_group_id, app_user);
alter table security_group_roles add constraint security_group_role_fk2 foreign key (role_code) references security_roles (role_code)
alter table security_group_roles add constraint security_group_role_activ_ck check (active_ind = 'Y');
