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
-- Name: check_in_syncs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_in_syncs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    status character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: check_in_syncs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.check_in_syncs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: check_in_syncs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.check_in_syncs_id_seq OWNED BY public.check_in_syncs.id;


--
-- Name: check_in_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_in_users (
    id bigint NOT NULL,
    check_in_id bigint NOT NULL,
    user_id bigint NOT NULL,
    relationship character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: check_in_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.check_in_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: check_in_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.check_in_users_id_seq OWNED BY public.check_in_users.id;


--
-- Name: check_ins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_ins (
    id bigint NOT NULL,
    check_in_sync_id bigint NOT NULL,
    external_id character varying NOT NULL,
    venue_id bigint,
    likes_count integer NOT NULL,
    comments_count integer NOT NULL,
    mayor boolean NOT NULL,
    external_created_at timestamp without time zone NOT NULL,
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
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    city character varying,
    avatar_url character varying,
    html_url character varying,
    check_ins_count integer,
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
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venues (
    id bigint NOT NULL,
    external_id character varying NOT NULL,
    name character varying NOT NULL,
    categories character varying[] NOT NULL,
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
-- Name: check_in_syncs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_syncs ALTER COLUMN id SET DEFAULT nextval('public.check_in_syncs_id_seq'::regclass);


--
-- Name: check_in_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_users ALTER COLUMN id SET DEFAULT nextval('public.check_in_users_id_seq'::regclass);


--
-- Name: check_ins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins ALTER COLUMN id SET DEFAULT nextval('public.check_ins_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


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
-- Name: check_in_syncs check_in_syncs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_syncs
    ADD CONSTRAINT check_in_syncs_pkey PRIMARY KEY (id);


--
-- Name: check_in_users check_in_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_users
    ADD CONSTRAINT check_in_users_pkey PRIMARY KEY (id);


--
-- Name: check_ins check_ins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT check_ins_pkey PRIMARY KEY (id);


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
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: index_check_in_syncs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_in_syncs_on_user_id ON public.check_in_syncs USING btree (user_id);


--
-- Name: index_check_in_users_on_check_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_in_users_on_check_in_id ON public.check_in_users USING btree (check_in_id);


--
-- Name: index_check_in_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_in_users_on_user_id ON public.check_in_users USING btree (user_id);


--
-- Name: index_check_ins_on_check_in_sync_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_ins_on_check_in_sync_id ON public.check_ins USING btree (check_in_sync_id);


--
-- Name: index_check_ins_on_check_in_sync_id_and_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_check_ins_on_check_in_sync_id_and_external_id ON public.check_ins USING btree (check_in_sync_id, external_id);


--
-- Name: index_check_ins_on_venue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_check_ins_on_venue_id ON public.check_ins USING btree (venue_id);


--
-- Name: index_users_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_external_id ON public.users USING btree (external_id);


--
-- Name: index_venues_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_venues_on_external_id ON public.venues USING btree (external_id);


--
-- Name: check_in_users fk_rails_16ed2eee1d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_users
    ADD CONSTRAINT fk_rails_16ed2eee1d FOREIGN KEY (check_in_id) REFERENCES public.check_ins(id);


--
-- Name: check_in_users fk_rails_5c8f046428; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_users
    ADD CONSTRAINT fk_rails_5c8f046428 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: check_in_syncs fk_rails_734dc3a770; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in_syncs
    ADD CONSTRAINT fk_rails_734dc3a770 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: check_ins fk_rails_760a86aec3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT fk_rails_760a86aec3 FOREIGN KEY (check_in_sync_id) REFERENCES public.check_in_syncs(id);


--
-- Name: check_ins fk_rails_8194594aa8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_ins
    ADD CONSTRAINT fk_rails_8194594aa8 FOREIGN KEY (venue_id) REFERENCES public.venues(id);


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
('20180820153727');


