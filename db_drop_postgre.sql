-- Drop foreign key constraints
ALTER TABLE public.access_list DROP CONSTRAINT IF EXISTS access_list_model_id_fkey;
ALTER TABLE public.access_list DROP CONSTRAINT IF EXISTS access_list_user_id_fkey;
ALTER TABLE public.constraint DROP CONSTRAINT IF EXISTS constraint_constraint_type_id_fkey;
ALTER TABLE public.constraint DROP CONSTRAINT IF EXISTS constraint_entity_id_fkey;
ALTER TABLE public.constraint_info DROP CONSTRAINT IF EXISTS constraint_info_constraint_id_fkey;
ALTER TABLE public.constraint_info DROP CONSTRAINT IF EXISTS constraint_info_object_id_fkey;
ALTER TABLE public.constraint_param DROP CONSTRAINT IF EXISTS constraint_param_constraint_id_fkey;
ALTER TABLE public.constraint_param DROP CONSTRAINT IF EXISTS constraint_param_param_id_fkey;
ALTER TABLE public.constraint_type DROP CONSTRAINT IF EXISTS constraint_type_pkey;
ALTER TABLE public.entity DROP CONSTRAINT IF EXISTS entity_sketch_id_fkey;
ALTER TABLE public.entity DROP CONSTRAINT IF EXISTS entity_pkey;
ALTER TABLE public.model DROP CONSTRAINT IF EXISTS model_creator_id_fkey;
ALTER TABLE public.model DROP CONSTRAINT IF EXISTS model_last_editor_id_fkey;
ALTER TABLE public.object DROP CONSTRAINT IF EXISTS object_object_id_fkey;
ALTER TABLE public.object DROP CONSTRAINT IF EXISTS object_object_type_id_fkey;
ALTER TABLE public.object DROP CONSTRAINT IF EXISTS object_parent_id_fkey;
ALTER TABLE public.object_param DROP CONSTRAINT IF EXISTS object_param_object_id_fkey;
ALTER TABLE public.object_param DROP CONSTRAINT IF EXISTS object_param_param_id_fkey;
ALTER TABLE public.param DROP CONSTRAINT IF EXISTS param_pkey;
ALTER TABLE public.plane DROP CONSTRAINT IF EXISTS plane_model_id_fkey;
ALTER TABLE public.sketch DROP CONSTRAINT IF EXISTS sketch_plane_id_fkey;
ALTER TABLE public.user DROP CONSTRAINT IF EXISTS user_pkey;

-- Drop tables
DROP TABLE IF EXISTS public.constraint_param;
DROP TABLE IF EXISTS public.constraint_info;
DROP TABLE IF EXISTS public.constraint;
DROP TABLE IF EXISTS public.constraint_type;
DROP TABLE IF EXISTS public.object_param;
DROP TABLE IF EXISTS public.object;
DROP TABLE IF EXISTS public.object_type;
DROP TABLE IF EXISTS public.param;
DROP TABLE IF EXISTS public.entity;
DROP TABLE IF EXISTS public.sketch;
DROP TABLE IF EXISTS public.plane;
DROP TABLE IF EXISTS public.access_list;
DROP TABLE IF EXISTS public.model;
DROP TABLE IF EXISTS public.user;