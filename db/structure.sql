SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: calendar(date, date, character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calendar(start_date date, end_date date, step character) RETURNS TABLE(period date)
    LANGUAGE sql STABLE
    AS $$
  select date_trunc(calendar.step, n::timestamp)::date as period
  from generate_series(calendar.start_date, calendar.end_date, ('1 ' || calendar.step)::interval) n
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    external_id character varying NOT NULL,
    name character varying NOT NULL,
    icon_prefix character varying NOT NULL,
    icon_suffix character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: check_in_tagged_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_in_tagged_users (
    id bigint NOT NULL,
    check_in_id bigint NOT NULL,
    user_id bigint NOT NULL,
    relationship character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: check_in_tagged_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.check_in_tagged_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: check_in_tagged_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.check_in_tagged_users_id_seq OWNED BY public.check_in_tagged_users.id;


--
-- Name: check_ins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_ins (
    id bigint NOT NULL,
    external_id character varying NOT NULL,
    user_id bigint NOT NULL,
    venue_id bigint,
    likes_count integer NOT NULL,
    comments_count integer NOT NULL,
    mayor boolean NOT NULL,
    external_created_at timestamp without time zone NOT NULL,
    shout character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: check_ins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.check_ins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: check_ins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.check_ins_id_seq OWNED BY public.check_ins.id;


--
-- Name: import_check_ins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.import_check_ins (
    id bigint NOT NULL,
    import_id bigint NOT NULL,
    check_in_id bigint NOT NULL
);


--
-- Name: import_check_ins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.import_check_ins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: import_check_ins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.import_check_ins_id_seq OWNED BY public.import_check_ins.id;


--
-- Name: imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imports (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    status character varying NOT NULL,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.imports_id_seq OWNED BY public.imports.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    external_id integer NOT NULL,
    external_created_at timestamp without time zone,
    token character varying,
    first_name character varying,
    last_name character varying,
    city character varying,
    check_ins_count integer,
    photo_prefix character varying,
    photo_suffix character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: venue_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venue_categories (
    id bigint NOT NULL,
    venue_id bigint NOT NULL,
    category_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: venue_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venue_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venue_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venue_categories_id_seq OWNED BY public.venue_categories.id;


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venues (
    id bigint NOT NULL,
    external_id character varying NOT NULL,
    name character varying NOT NULL,
    location_lat double precision NOT NULL,
    location_lng double precision NOT NULL,
    location_country_code character varying NOT NULL,
    location_country character varying NOT NULL,
    location_address character varying,
    location_formatted_address character varying[] NOT NULL,
    location_city character varying,
    location_state character varying,
    location_postal_code character varying,
    rating double precision,
    rating_sync_status character varying,
    rating_last_synced_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venues_id_seq OWNED BY public.venues.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: check_in_tagged_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_tagged_users ALTER COLUMN id SET DEFAULT nextval('public.check_in_tagged_users_id_seq'::regclass);


--
-- Name: check_ins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins ALTER COLUMN id SET DEFAULT nextval('public.check_ins_id_seq'::regclass);


--
-- Name: import_check_ins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_check_ins ALTER COLUMN id SET DEFAULT nextval('public.import_check_ins_id_seq'::regclass);


--
-- Name: imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports ALTER COLUMN id SET DEFAULT nextval('public.imports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: venue_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_categories ALTER COLUMN id SET DEFAULT nextval('public.venue_categories_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues ALTER COLUMN id SET DEFAULT nextval('public.venues_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: check_in_tagged_users check_in_tagged_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_tagged_users
    ADD CONSTRAINT check_in_tagged_users_pkey PRIMARY KEY (id);


--
-- Name: check_ins check_ins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT check_ins_pkey PRIMARY KEY (id);


--
-- Name: import_check_ins import_check_ins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_check_ins
    ADD CONSTRAINT import_check_ins_pkey PRIMARY KEY (id);


--
-- Name: imports imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venue_categories venue_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_categories
    ADD CONSTRAINT venue_categories_pkey PRIMARY KEY (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: index_categories_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_categories_on_external_id ON public.categories USING btree (external_id);


--
-- Name: index_check_in_tagged_users_on_check_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_in_tagged_users_on_check_in_id ON public.check_in_tagged_users USING btree (check_in_id);


--
-- Name: index_check_in_tagged_users_on_check_in_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_check_in_tagged_users_on_check_in_id_and_user_id ON public.check_in_tagged_users USING btree (check_in_id, user_id);


--
-- Name: index_check_in_tagged_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_in_tagged_users_on_user_id ON public.check_in_tagged_users USING btree (user_id);


--
-- Name: index_check_ins_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_check_ins_on_external_id ON public.check_ins USING btree (external_id);


--
-- Name: index_check_ins_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_ins_on_user_id ON public.check_ins USING btree (user_id);


--
-- Name: index_check_ins_on_venue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_ins_on_venue_id ON public.check_ins USING btree (venue_id);


--
-- Name: index_import_check_ins_on_check_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_import_check_ins_on_check_in_id ON public.import_check_ins USING btree (check_in_id);


--
-- Name: index_import_check_ins_on_import_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_import_check_ins_on_import_id ON public.import_check_ins USING btree (import_id);


--
-- Name: index_imports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_user_id ON public.imports USING btree (user_id);


--
-- Name: index_users_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_external_id ON public.users USING btree (external_id);


--
-- Name: index_venue_categories_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_venue_categories_on_category_id ON public.venue_categories USING btree (category_id);


--
-- Name: index_venue_categories_on_venue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_venue_categories_on_venue_id ON public.venue_categories USING btree (venue_id);


--
-- Name: index_venue_categories_on_venue_id_and_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_venue_categories_on_venue_id_and_category_id ON public.venue_categories USING btree (venue_id, category_id);


--
-- Name: index_venues_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_venues_on_external_id ON public.venues USING btree (external_id);


--
-- Name: index_venues_on_rating; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_venues_on_rating ON public.venues USING btree (rating);


--
-- Name: check_in_tagged_users fk_rails_0dbd688f66; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_tagged_users
    ADD CONSTRAINT fk_rails_0dbd688f66 FOREIGN KEY (check_in_id) REFERENCES public.check_ins(id) ON DELETE CASCADE;


--
-- Name: venue_categories fk_rails_1a66f97c7e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_categories
    ADD CONSTRAINT fk_rails_1a66f97c7e FOREIGN KEY (venue_id) REFERENCES public.venues(id);


--
-- Name: import_check_ins fk_rails_2b9ad2f6d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_check_ins
    ADD CONSTRAINT fk_rails_2b9ad2f6d4 FOREIGN KEY (check_in_id) REFERENCES public.check_ins(id) ON DELETE CASCADE;


--
-- Name: venue_categories fk_rails_678164640c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_categories
    ADD CONSTRAINT fk_rails_678164640c FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: check_ins fk_rails_8194594aa8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT fk_rails_8194594aa8 FOREIGN KEY (venue_id) REFERENCES public.venues(id);


--
-- Name: check_ins fk_rails_b15c016c97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT fk_rails_b15c016c97 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: imports fk_rails_b1e2154c26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT fk_rails_b1e2154c26 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: check_in_tagged_users fk_rails_b817b41781; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_tagged_users
    ADD CONSTRAINT fk_rails_b817b41781 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: import_check_ins fk_rails_dcb4b7de4b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_check_ins
    ADD CONSTRAINT fk_rails_dcb4b7de4b FOREIGN KEY (import_id) REFERENCES public.imports(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180819163918'),
('20180819185732'),
('20180819204503'),
('20180819204516'),
('20180820152026'),
('20180820152345'),
('20180820153727'),
('20180820154136'),
('20180820154424'),
('20180820164751'),
('20180820165527'),
('20180821025558'),
('20180821035619'),
('20180821194749'),
('20180821195825'),
('20180821211412'),
('20180821214314'),
('20180823031413'),
('20180826154304'),
('20180826160047'),
('20180826161843');


