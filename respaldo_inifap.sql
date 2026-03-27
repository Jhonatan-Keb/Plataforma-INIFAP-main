--
-- PostgreSQL database dump
--

\restrict EVAq03h6NIagMdfETPJEUJLteV81Nbt1JYdW4okJku7lB8yqdiUrbDKYfmxe86K

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: files; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.files (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    title character varying(255),
    description text,
    path character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    file_type character varying(255),
    category character varying(255),
    size bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.files OWNER TO inifap_user;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: inifap_user
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO inifap_user;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inifap_user
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: media_archivos; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.media_archivos (
    id bigint NOT NULL,
    publicacion_id bigint,
    nombre_original character varying(255) NOT NULL,
    ruta character varying(500) NOT NULL,
    tipo_mime character varying(100) NOT NULL,
    tipo_medio character varying(255) NOT NULL,
    extension character varying(15),
    tamanio bigint,
    es_portada boolean DEFAULT false NOT NULL,
    descripcion text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT media_archivos_tipo_medio_check CHECK (((tipo_medio)::text = ANY ((ARRAY['imagen'::character varying, 'gif'::character varying, 'video'::character varying, 'audio'::character varying, 'documento'::character varying])::text[])))
);


ALTER TABLE public.media_archivos OWNER TO inifap_user;

--
-- Name: media_archivos_id_seq; Type: SEQUENCE; Schema: public; Owner: inifap_user
--

CREATE SEQUENCE public.media_archivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.media_archivos_id_seq OWNER TO inifap_user;

--
-- Name: media_archivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inifap_user
--

ALTER SEQUENCE public.media_archivos_id_seq OWNED BY public.media_archivos.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO inifap_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: inifap_user
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO inifap_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inifap_user
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: publicaciones; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.publicaciones (
    id bigint NOT NULL,
    titulo character varying(500) NOT NULL,
    titulo_en character varying(500),
    ano smallint,
    categoria character varying(255) NOT NULL,
    tipo character varying(50) DEFAULT 'pdf'::character varying NOT NULL,
    portada_path character varying(255),
    file_path character varying(255),
    external_url character varying(500),
    mensaje character varying(500),
    cuenta smallint DEFAULT '0'::smallint NOT NULL,
    created_by bigint,
    is_published boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT publicaciones_categoria_check CHECK (((categoria)::text = ANY ((ARRAY['cientifica'::character varying, 'tecnica'::character varying, 'ilustracion'::character varying])::text[])))
);


ALTER TABLE public.publicaciones OWNER TO inifap_user;

--
-- Name: publicaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: inifap_user
--

CREATE SEQUENCE public.publicaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publicaciones_id_seq OWNER TO inifap_user;

--
-- Name: publicaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inifap_user
--

ALTER SEQUENCE public.publicaciones_id_seq OWNED BY public.publicaciones.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO inifap_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: inifap_user
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    is_contributor boolean DEFAULT false NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO inifap_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: inifap_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO inifap_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inifap_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: media_archivos id; Type: DEFAULT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.media_archivos ALTER COLUMN id SET DEFAULT nextval('public.media_archivos_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: publicaciones id; Type: DEFAULT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.publicaciones ALTER COLUMN id SET DEFAULT nextval('public.publicaciones_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.files (id, name, title, description, path, type, file_type, category, size, created_at, updated_at) FROM stdin;
2	01. FORMATO_Carta de asignación SS.pdf	Prueba	lkl	uploads/archivos/ooycwd0KhONcQRkHBiOBfGnGjIsac8bGyaAQHP8g.pdf	application/pdf	PDF	Publicación Científica	321632	2026-03-20 17:02:12	2026-03-20 17:02:12
3	잘생쁨이 뭔지 보여주는 윈터 #윈터 #WINTER #에스파 #aespa #Whiplash [7Gs6ocHDCKE].webm	Teodio	Teodio	uploads/archivos/qZ9q03pkVgHZaBkARSc7aLypWATvCj2TZdu2G9cM.webm	video/webm	Video	Vídeo	52415540	2026-03-26 17:24:19	2026-03-26 17:24:19
4	B1-04-Would-PastTense.mp3	MIra we	un video we	uploads/archivos/uoB7ReRk7OqsZpMuTV3L43Ymwaz4fYExjvpWOggI.mp3	audio/mpeg	Audio	Vídeo	4805484	2026-03-26 18:03:15	2026-03-26 18:03:15
\.


--
-- Data for Name: media_archivos; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.media_archivos (id, publicacion_id, nombre_original, ruta, tipo_mime, tipo_medio, extension, tamanio, es_portada, descripcion, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2025_11_28_000000_create_users_table	1
2	2025_11_28_000001_create_publicaciones_table	1
3	2026_02_12_004847_create_sessions_table	1
4	2026_03_20_000000_create_media_archivos_table	1
5	2026_03_20_000001_create_files_table	2
\.


--
-- Data for Name: publicaciones; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.publicaciones (id, titulo, titulo_en, ano, categoria, tipo, portada_path, file_path, external_url, mensaje, cuenta, created_by, is_published, created_at, updated_at) FROM stdin;
1	Victoria Un clon criollo de durazno (Prunus persica L.) de hueso pegado para Zacatecas.	Victoria, A native clingstone peah (Prunus persica L.) clone for Zacatecas.	1999	cientifica	pdf	\N	Victoria.pdf	\N	\N	407	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
2	Control de malezas y respuesta del frijol al cultivo, azadoneo rotatorio y herbicidas en la hilera de siembra.	Weed Control and Dry Bean Response to In-Row Cultivation, Rotary Hoeing and Herbicides.	2001	cientifica	pdf	\N	Weed_Control.pdf	\N	\N	393	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
3	Caracterización hidrológica en un agostadero comunal excluido al pastoreo en Zacatecas, México I. Pérdidas de suelo.	Hydrological characterization of a communal rangeland excluded from cattle grazing al Zacatecas, Mexico I. Soil losses.	2002	cientifica	pdf	\N	caracterizacion_hidrologica_1.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
4	Caracterización hidrológica en un agostadero comunal excluido al pastoreo en Zacatecas, México II. Escurrimiento superficial.	Hydrological characterization of a communal rangeland excluded from cattle grazing al Zacatecas, Mexico II. Surface runoff.	2002	cientifica	pdf	\N	caracterizacion_hidrologica_2.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
5	Período crítico del control de malezas en chile trasplantado.	Critical Period of Weed Control in Transplanted Chilli Pepper.	2002	cientifica	pdf	\N	Critical_Period.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
6	Efecto del cultivo en la hilera de siembra, herbicidas y cubierta del frijol en la emergencia de plántulas de maleza.	Effect of in-row cultivation, herbicide and dry bean canopy on weed seedling emergence.	2002	cientifica	pdf	\N	Effect_of_in_row_cultivation.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
7	Relaciones hídricas, rendimiento de tomate para proceso bajo riego parcial de la raíz.	Water relations, rrowth, and yield of processing tomatoes under partial rootzone drying.	2003	cientifica	pdf	\N	water_relation_tomatoes.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
8	Labranza reducida y convencional en la distribución espacial de la maleza y rendimiento de frijol.	Effect of Reduced and Conventional Tillage on the Spatial Distribution of Weed and Dry Bean Yield.	2003	cientifica	pdf	\N	Labranza_reducida.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
9	El riego deficitario y riego parcial de la raÃ­z mantienen el peso seco del fruto y mejora la calidad del fruto del tomate para proceso Petropride (Lycopersicon esculentum, Mill.).	Deficit irrigation and partial rootzone drying maintain fruit dry mass and enhance fruit quality in Petopride processing tomato (Lycopersicon esculentum, Mill.).	2003	cientifica	pdf	\N	deficit_irrigation.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
10	El riego parcial de la raÃ­z es una opciÃ³n factible para regar el tomate para proceso.	Partial rootzone drying is a feasible option for irrigating processing tomatoes.	2004	cientifica	pdf	\N	partial_rootzone.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
11	Contenidos minerales de uva, aceituna, manzano y tomate bajo riego reducido.	Mineral contents of grape, olive, apple, and tomato under reduced irrigation.	2004	cientifica	pdf	\N	mineral_contents.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
12	Identificación de áreas susceptibles de reconversión de suelos agrícolas hacia agostadero y su conservación en el ejido Pánuco, Zacatecas, MÃ©xico.	Identification of areas for reconversion from agricultural to rangeland use and soil conservation in the Panuco ejido, Zacatecas, MÃ©xico.	2004	cientifica	pdf	\N	identificacion_de_areas.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
13	Distribuciones espaciales de malezas y rendimiento de maíz en labranza reducida y convencional.	Weed and corn yield spatial distributions in reduced and conventional tillage.	2004	cientifica	pdf	\N	Distribuciones.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
14	Relaciones hÃ­dricas, crecimiento, rendimiento y calidad de fruta de chile ancho bajo riego deficitario y riego parcial de la raÃ­z.	Water relations, growth, yield, and fruit quality of hot pepper under deficit irrigation and partial rootzone drying.	2005	cientifica	pdf	\N	water_relation_fruit.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
15	Respuesta del tomate para proceso Petropride al riego parcial de la raÃ­z en diferentes estadÃ­os fenolÃ³gicos.	Responses of Petopride processing tomato to partial rootzone drying at different phenological stages.	2005	cientifica	pdf	\N	responses_of_petopride.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
16	Cambios estacionales de nutrimentos en hojas y caída de fruta en durazno Criollo de Zacatecas, México.	Seasonal changes of nutriments in leaves and fruit drop of Criollo Peach in Zacatecas, MÃ©xico.	2005	cientifica	pdf	\N	cambios_estacionales.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
17	Riego parcial de raíz en manzano 'Golden Delicious' en un ambiente semi-árido.	Partial Rootzone Irrigation Of Golden Delicious Apple Trees In A Semi-Arid Environment.	2006	cientifica	pdf	\N	RiegoParcialdeRaiz.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
18	Rentabilidad del chile seco en Zacatecas, México.	Profitability Of Dry Chili At Zacatecas, MÃ©xico.	2006	cientifica	pdf	\N	Art_FITOTECNIA_aceptado_2006.pdf	\N	\N	400	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
19	Influencia del sistema de pastoreo con pequeños rumiantes en agostadero del semiárido Zacatecaco. I Vegetación nativa.	Influence of small ruminant grazing systems in a semiarid range in the State of Zacatecas Mexico. I Native vegetation	2006	cientifica	pdf	\N	sistema_de_pastoreo.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
20	Emisiones de Dioxido de Carbono desde Horizontes Petrocalcicos Exhumados.	Carbon Dioxide Emissions from Exhumed Petrocalcic Horizons.	2006	cientifica	pdf	\N	Serna_Monger_Herrick_Murray.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
21	Rendimiento y calidad de fruta en tomate para proceso bajo riego parcial de la raÃ­z.	Yield and fruit quality in processing tomato under partial rootzone drying.	2006	cientifica	pdf	\N	252_258JZegbe.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
22	Representación del movimiento de bromuro con la técnica de visualización volumétrica.	\N	2006	cientifica	pdf	\N	movimiento.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
23	Influencia del sistema de pastoreo con pequeños rumiantes en un agostadero del semiárido Zacatecano: II Cambios en el suelo.	Influence of small ruminant grazing systems in a semiarid range in the State of Zacatecas (Mexico): II Soil changes.	2007	cientifica	pdf	\N	cambios_en_el_suelo.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
24	Respuesta del tomate al riego parial de la raíz y déficit hídrico.	Response Of Tomato To Partial Rootzone Drying And Deficit Irrigation.	2007	cientifica	pdf	\N	PRD_RFMex_07.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
25	Respuesta del tomate para proceso al riego parcial de la raíz.	Response of Processing Tomato to Partial Rootzone Irrigation.	2007	cientifica	pdf	\N	PRD_Terra_2007.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
26	Respuesta del manzano "PACIFIC ROSE" al riego parcial de raíz.	Response Of PACIFIC ROSE Apple To Partial Root Irrigation.	2007	cientifica	pdf	\N	PRD_AppleRev_2007.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
27	Poda de ramas mixtas y raleo de frutos: prácticas culturales independientes en durazno Victoria.	Fruiting Shoots Pruning And Fruit Thinning: Two Independent Cultural Practices In Victoria Peach.	2007	cientifica	pdf	\N	DespunteDurazno_2007.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
28	Riego reducido mantiene la fotosÃ­ntesis, crecimiento, rendimiento y calidad de fruta en el manzano Pacific Rose.	Reduced irrigation maintains photosynthesis, growth, yield, and fruit quality in Pacific Rose apple.	2007	cientifica	pdf	\N	PRDApple.pdf	\N	\N	390	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
29	Estado hÃ­drico del Ã¡rbol, asimilaciÃ³n de CO2, rendimiento y calidad de la manzana Pacific Rose bajo riego parcial de la raÃ­z.	Plant water status, CO2 assimilation, yield, and fruit quality of Pacific Rose apple under partial rootzone drying.	2008	cientifica	pdf	\N	AdvHortSci_22_1_2008.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
30	Retraso de la cosecha en nopal tunero cv. cristalina.	Harvest Delaying In Cactus Pear Cv. Cristalina.	2008	cientifica	pdf	\N	Tuna_JZegbe.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
31	Comportamiento postcosecha de la manzana Pacific Rose cultivada bajo riego parcial de la raÃ­z.	Postharvest performance of pacific rose apple grown under partial rootzone drying.	2008	cientifica	pdf	\N	HortSCi.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
32	Â¿Remover las yemas reproductivas afecha la Ã©poca de cosecha del nopal tunero?.	Does reproductive bud removal affect harvest timing of cactus pear?.	2008	cientifica	pdf	\N	Zegbe_Mena_RevFitoTecMex_2008.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
33	Sistemas de manejo para la producciÃ³n sustentable de chile seco cv. MIRASOL.	Management systems for sustainable production of dry pepper cv. MIRASOL.	2008	cientifica	pdf	\N	Serna_RevFitotMex_2008.pdf	\N	\N	390	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
34	Empleo de marcadores moleculares en la identificaciÃ³n de razas caprinas del estado de Zacatecas, MÃ©xico.	Use of molecular markers to differentiate goat breeds from Zacatecas, MÃ©xico.	2008	cientifica	pdf	\N	celtiberica.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
35	Productividad del chamizo Atriplex canescens con fines de reconversiÃ³n: dos casos de estudio.	An assessment of Fourwing saltbush (Atriplex canescens) productivity for crop conversion potential in two study cases.	2009	cientifica	pdf	\N	chamizo_reconversion.pdf	\N	\N	403	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
36	EstimaciÃ³n de la producciÃ³n de forraje con imÃ¡genes de satÃ©lite en los pastizales de Zacatecas.	Use of satellite images to assess forage production in the rangelands of Zacatecas.	2009	cientifica	pdf	\N	Estimacion_Via_Satelite.pdf	\N	\N	399	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
37	El riego parcial de la raÃ­z incrementa la productividad del agua en manzano en un ambiente SEMI-ÃRIDO.	Partial rootzone drying improves water productivity of apples in a semi-arid environment.	2009	cientifica	pdf	\N	RPRmanzano.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
38	Flower bud thinning in 'Rojo Liso' cactus pear.	Flower bud thinning in Rojo Liso cactus pear.	2009	cientifica	pdf	\N	JHSB.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
39	Dos alternativas de raleo de yemas reproductivas para nopal tunero.	Two reproductive bud thinning alternatives for cactus pear.	2010	cientifica	pdf	\N	altNopalTunero.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
40	Cambios postcosecha en la pÃ©rdida de peso y calidad de la tuna de nopal tunero sometido a raleo de yemas reproductivas.	Postharvest changes in weight loss and quality of cactus pear fruit undergoing reproductive bud thinning.	2010	cientifica	pdf	\N	Postharvest.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
41	Impactos de pequeÃ±os rumiantes sobre los pastizales del altiplano semiarido de MÃ©xico y la reconversiÃ³n por sistemas de pastoreo.	\N	2010	cientifica	pdf	\N	\N	\N	Si Usted estÃ¡ interesado (a) por esta publicaciÃ³n, por favor solicÃ­tela por correo electrÃ³nico a la siguiente direcciÃ³n: fechava@zacatecas.inifap.gob.mx	364	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
42	Influence of nutritional and socio-sexual cues upon reproductive efficiency of goats exposed to the male effect under extensive conditions.	\N	2010	cientifica	pdf	\N	\N	\N	Si Usted estÃ¡ interesado (a) por esta publicaciÃ³n, por favor solicÃ­tela por correo electrÃ³nico a la siguiente direcciÃ³n: fechava@zacatecas.inifap.gob.mx	364	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
43	Relaciones hÃ­dricas, intercambio gaseoso y rendimiento de Tomate para proceso bajo riego reducido.	Water relations, gas exchange, and yield of processing tomato under reduced irrigation.	2010	cientifica	pdf	\N	Cien_Agri_Zegbe.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
44	Modelo regional para predecir el rendimiento de frijol de temporal en MÃ©xico.	Large-area dry bean yield prediction modeling in MÃ©xico.	2010	cientifica	pdf	\N	modeloRegPred.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
45	El riego parcial de la raÃ­z mantiene la calidad de la fruta de manzano Golden Delicious a la cosecha y postcosecha.	Partial rootzone drying maintains fruit quality of Golden Delicious apples at harvest and postharvest.	2011	cientifica	pdf	\N	riegoManzanoGolden.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
46	Estado nutricional de hojas de manzano no afectadas por tres aÃ±os de riego usando riego parcial de la raÃ­z.	Nutrient status of apple leaves not affected by three years of irrigation using partial root zone drying.	2011	cientifica	pdf	\N	estadoNutricionalManzano.pdf	\N	\N	402	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
47	Rendimiento y calidad de chile seco Mirasol cultivado bajo riego parcial de la raÃ­z.	Yield and fruit quality of Mirasol dry chili cropped under partial rootzone drying.	2011	cientifica	pdf	\N	HortOnce.pdf	\N	\N	393	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
48	Â¿Es la materia seca un Ã­ndice seguro para la fruta del kiwi Hayward?	Is dry matter a reliable quality index for hayward kiwifruit?.	2011	cientifica	pdf	\N	Crisostoetal.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
49	Efecto de aplicaciÃ³n de glomus intraradices en el desarrollo Vegetativo y radicular de plÃ¡ntulas de curcubita pepo l.	Effect of application of glomus intraradices on the vegetative and root growth of cucurbita pepo l. plantlets.	2011	cientifica	pdf	\N	AplicacionDeglomus.pdf	\N	\N	400	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
50	CEZAC 06 : nueva variedad de ajo tipo jaspeado para la regiÃ³n norte centro de MÃ©xico.	Cezac 06: new jaspeado garlic cultivar for the northem-central region of MÃ©xico.	2011	cientifica	pdf	\N	ARTICULOCEZAC.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
51	Hacia un enfoque de investigaciÃ³n participativa para mejorar los Sistemas de ProducciÃ³n de Caprinos en regiones semiÃ¡ridas de MÃ©xico: Una caracterizaciÃ³n socioeconÃ³mica y ecolÃ³gica.	Towards a participatory research approach to improve goats production systems in semi arid MÃ©xico: Socioeconomic and ecological.	2011	cientifica	pdf	\N	echavarriaet.pdf	\N	\N	392	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
52	Efecto del cambio climÃ¡tico en la acumulaciÃ³n de frÃ­o en la regiÃ³n manzanera de chihuahua.	Effect of climate change in the cold accumulation in the apple producing region of Chihuahua.	2011	cientifica	pdf	\N	efectoCCChihu.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
53	Riego parcial de la raÃ­z para el ahorro de agua mientras se cultiva el manzano en una regiÃ³n semi-Ã¡rida.	Partial rootzone drying to save water while growing apples in a semi-arid region.	2012	cientifica	pdf	\N	riegoParcialRaiz.pdf	\N	\N	395	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
54	Nuevo Ã­ndice de calidad basado en la materia seca y acidez propuesto para la fruta del kiwi Hayward.	New quality index based on dry matter and acidity proposed for Hayward kiwifruit.	2012	cientifica	pdf	\N	CalifAgricJZegbe.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
55	Rendimiento, calidad de fruto y eficiencia en el uso del agua del chile "mirasol" bajo riego deficitario.	Yield, fruit quality and water use efficiency of chili "mirasol" under irrigation deficit.	2012	cientifica	pdf	\N	rendimiento9a.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
56	Exposicion al fotoperiodo largo en la induccion de cabras lactantes.	\N	2013	cientifica	pdf	\N	\N	\N	Si Usted estÃ¡ interesado (a) por esta publicaciÃ³n, por favor solicÃ­tela por correo electrÃ³nico a la siguiente direcciÃ³n: mflores@zacatecas.inifap.gob.mx	365	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
57	Actividad ovulatoria post parto.	\N	2013	cientifica	pdf	\N	\N	\N	Si Usted estÃ¡ interesado (a) por esta publicaciÃ³n, por favor solicÃ­tela por correo electrÃ³nico a la siguiente direcciÃ³n: mflores@zacatecas.inifap.gob.mx	364	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
58	Cambio climÃ¡tico y sus implicaciones en cinco zonas productoras de maÃ­z en MÃ©xico.	Climate change and its implications in five producing areas of maize in MÃ©xico.	2011	cientifica	pdf	\N	cambioClima.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
59	Perspectivas del sistema de producciÃ³n de manzano en chihuahua, ante el cambio climÃ¡tico.	Perspectives on the apple production system in Chihuahua facing climate change.	2011	cientifica	pdf	\N	cambioClimManz.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
60	Razas mexicanas de maÃ­z como fuente de germoplasma para la adaptaciÃ³n al cambio climÃ¡tico.	Mexican maize races as a germplasm source for adaptation to climate change.	2011	cientifica	pdf	\N	germoplazma.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
61	Presencia de Circulifer tenellus Baker y Beet mild curly top virus en maleza durante el invierno en el centro norte de MÃ©xico	Circulifer tenellus Baker and Beet mild curly top virus presence in weeds during the winter in north-central Mexico.	2012	cientifica	pdf	\N	presmalin.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
62	Respuesta del chile mirasol a la labranza reducida, enmiendas al suelo y acolchado plÃ¡stico.	Response of Mirasol chili pepper to reduced tillage, soil amendments and plastic mulch.	2013	cientifica	pdf	\N	labRedChileMari.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
63	Propuesta para evaluar el proceso de adopciÃ³n de las innovaciones tecnolÃ³gicas.	Proposal to evaluate the process of adoption of technological innovations.	2013	cientifica	pdf	\N	proposalI.pdf	\N	\N	392	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
64	Estructura econÃ³mica competitiva del sector agropecuario de Zacatecas: Un anÃ¡lisis por agrocadenas.	Competitive economic structure of the agricultural and livestock sector of Zacatecas: An analysis by agro-chains.	2013	cientifica	pdf	\N	estecoagZac.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
65	Efecto del manejo reducido y convencional en chile mirasol en la regiÃ³n norte centro de MÃ©xico.	Effect of reduced and conventional management on dry chili pepper at the North Central Region of MÃ©xico.	2013	cientifica	pdf	\N	efectochilemirasol.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
66	Hortalizas y virosis en zacatecas: un patosistema complejo.	Vegetables and viruses in Zacatecas: A complex pathosystem.	2013	cientifica	pdf	\N	hortavir13.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
67	DetecciÃ³n de Infecciones Mixtas Causadas por Begomovirus y Curtovirus en Plantas de Chile para Secado en San Luis PotosÃ­, MÃ©xico.	Detection of Mixed Infections Caused by Begomovirus and Curtovirus in Chili pepper for drying plants in San Luis Potosi, Mexico.	2012	cientifica	pdf	\N	detInfeMixt.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
68	Efecto de la PreparaciÃ³n del Suelo en la DispersiÃ³n de Esclerocios de Sclerotium cepivorum Berk.	Effect of Soil Preparation in Dispersion of Sclerotia of Sclerotium cepivorum Berk.	2012	cientifica	pdf	\N	efctPrepSuelo.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
69	La nutriciÃ³n mineral mejora el rendimiento y afecta la calidad de la fruta del nopal tunero 'Cristalina'	Mineral nutrition enhances yield and affects fruit quality of 'Cristalina' cactus pear	2014	cientifica	pdf	\N	mineralNutricion.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
70	AnÃ¡lisis econÃ³mico de la aplicaciÃ³n de fertilizantes minerales en el rendimiento del nopal tunero.	Economic analysis of the application of mineral fertilizers on the yield of prickly pear.	2014	cientifica	pdf	\N	anEcoNopalT.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
71	Vectores potenciales de virus en frutales de hueso en Aguascalientes, Zacatecas y norte de Jalisco, MÃ©xico.	Potential virus vectors in stone fruit trees in Aguascalientes, Zacatecas and northern Jalisco, Mexico.	2014	cientifica	pdf	\N	vectoresPot.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
72	Una nueva cepa del Virus del Chino del Tomate aislado de plantas de soya (Glycine max L.) en MÃ©xico	A new strain of Chino del Tomate Virus isolated from soybean plants (Glycine max L.) in Mexico	2014	cientifica	pdf	\N	cepaVirusChino.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
73	FloraciÃ³n y fructificaciÃ³n de chile mirasol (Capsicum annuum L.) con labranza reducida, labranza convencional o incorporaciÃ³n de avena al suelo.	Flowering and fruiting of Mirasol pepper (Capsicum annuum L.) with minimum tillage, conventional tillage or addition of oats to the soil	2014	cientifica	pdf	\N	floFruCap.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
74	ProducciÃ³n y calidad de forraje de variedades de avena en condiciones de temporal en Zacatecas, MÃ©xico	Yield and forage quality of oats varieties under rainfed conditions in Zacatecas, Mexico	2014	cientifica	pdf	\N	prodAvenaTZac.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
75	El riego en nopal influye en el almacenamiento y acondicionamiento de la tuna.	Irrigation in nopal influences the storage and packaging of tuna	2014	cientifica	pdf	\N	JZegbe2014RevMex.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
76	Vectores potenciales de virus en frutales de hueso en Aguascalientes, Zacatecas y norte de Jalisco, MÃ©xico.	Potential virus vectors in stone fruit trees in Aguascalientes, Zacatecas and northern Jalisco, Mexico.	2014	cientifica	pdf	\N	vectoresVirusFrutalesAguascalientes.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
77	InducciÃ³n de lluvia mediante sembrado de nubes con yoduro de plata en la regiÃ³n norte-centro de MÃ©xico en la temporada de lluvia 2012.	Stimulation of rain using silver iodide cloud-seeding over northern central Mexico during the 2012 wet season.	2014	cientifica	pdf	\N	induccionLluvia.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
78	Ãndices de extremos tÃ©rmicos en las Llanuras Costeras del Golfo Sur en MÃ©xico.	Indices of temperature extremes in the South Gulf Coastal Plains in Mexico.	2014	cientifica	pdf	\N	indicesExtremosGolfoSurMexico.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
79	Impacto potencial del cambio climÃ¡tico en la regiÃ³n productora de durazno en Zacatecas, MÃ©xico.	Potential impact of climate change on the peach producing region in Zacatecas, Mexico.	2014	cientifica	pdf	\N	impactoPotencialDurazno.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
80	Efecto de la condiciÃ³n ENSO en la frecuencia e intensidad de los eventos de lluvia en la penÃ­nsula de Baja California (1998-2012).	Effect of the ENSO condition in the frequency and intensity of rainfall events in the Baja California peninsula (1998-2012).	2014	cientifica	pdf	\N	condicionENSO.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
81	Cambio climÃ¡tico en MÃ©xico y distribuciÃ³n potencial del grupo racial de maÃ­z cÃ³nico.	Climate Change in Mexico and potential distribution of racial groups conical maize.	2014	cientifica	pdf	\N	cambioClimaticoMaizConico.pdf	\N	\N	397	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
82	MucÃ­lago de nopal como pelÃ­cula de recubrimiento para mejorar la vida de anaquel de la guayaba para consumo en fresco (Psidium guajava L.)	Cactus mucilage as a coating film to enhance shelf life of unprocessed guavas (Psidium guajava L.)	2015	cientifica	pdf	\N	cactusMucilage Unprocessed.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
83	El riego mejora el comportamiento postcosecha de la tuna Cristalina	Irrigation enhances postharvest performance of Cristalina cactus pear fruit	2015	cientifica	pdf	\N	IrrigationCristalinCactus.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
84	CaracterÃ­sticas forrajeras de variedades de triticale en condiciones de sequÃ­a.	Forage characteristics of triticale varieties under drought.	2015	cientifica	pdf	\N	Triticale_publicacion.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
85	Avances de la evaluaciÃ³n experimental de Beauveria bassiana como control biolÃ³gico de la chicharrita (Circulifer tenellus) presente en Zacatecas.	Advances in experimental evaluation of Beauveria bassiana as a biological control planthopper (Circulifer tenellus) present in Zacatecas	2014	cientifica	pdf	\N	bBassianaCBio.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
86	ComparaciÃ³n estomÃ¡tica en hojas de chile para secado (Capsicum annuum L.) asintomÃ¡ticas y con sÃ­ntomas de amarillamiento.	Comparison stomatal sheets for drying chili (Capsicum annuum L.), asymptomatic and yellowing symptoms.	2014	cientifica	pdf	\N	cEstomaticaChile.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
87	Crecimiento y rendimiento de cinco nuevos clones de ajo (Allium sativum L.) en campos de productores en Zacatecas.	Growth and yield of five new clones of garlic (Allium sativum L.) in farmer's fields in Zacatecas.	2014	cientifica	pdf	\N	clonesAjo.pdf	\N	\N	398	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
88	EvaluaciÃ³n de marcadores moleculares para la mediciÃ³n de la diversidad genÃ©tica de Capsicum annum L. del banco de germoplasma del Inifap-Zacatecas.	Evaluation of molecular markers for measuring the genetic diversity of Capsicum annum L. genebank of Inifap-Zacatecas.	2014	cientifica	pdf	\N	marcMolecularesBancoZac.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
89	Presencia de fitoplasmas en maleza de Aguascalientes y Zacatecas.	Phytoplasma presence in weed of Aguascalientes and Zacatecas	2014	cientifica	pdf	\N	fitoMalezaAguZac.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
90	OrientaciÃ³n de semilla, rendimiento y calidad de ajo (Allium Sativum l.) en dos variedades para Zacatecas.	Orientation of seed, yield and quality of garlic (Allium sativum L.) in two varieties for Zacatecas.	2014	cientifica	pdf	\N	orRenCalAjoZac.pdf	\N	\N	416	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
91	Brote de Candidatus Liberibacter Solanacearum en chile para secado en Durango, MÃ©xico.	Outbreak of Candidatus Liberibacter Solanacearum in dried chile pepper in Durango, Mexico.	2014	cientifica	pdf	\N	broteChileDurango.pdf	\N	\N	391	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
92	Presencia de fitoplasmasen el CicadÃ©lido Circullifer Tenellus en el estado de Zacatecas, MÃ©xico.	Presence of phytoplasma in the CicadÃ©lido Circullifer Tenellus in the state of Zacatecas, MÃ©xico.	2014	cientifica	pdf	\N	fitoCicadelidoZac.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
93	DetecciÃ³n de fitoplasmas en poblaciones de Dalbulus, Empoasca, Graminella y Aceratagallia presentes en el estado de Zacatecas, MÃ©xico.	Detection of phytoplasma in populations of Dalbulus, Empoasca, Graminella y Aceratagallia from the state of Zacatecas, Mexico.	2014	cientifica	pdf	\N	detFitoDEGAZac.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
94	Razas actuales de maÃ­z de secano en el estado de Zacatecas, MÃ©xico.	Current rainfed maize raices in the state of Zacatecas, Mexico.	2014	cientifica	pdf	\N	rActualesMaizSecano.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
95	Rendimiento y calidad de fruto de cuatro lÃ­neas de chile ancho en Zacatecas, MÃ©xico.	Yield and fruit quality of four ancho pepper lines in Zacatecas, MÃ©xico.	2014	cientifica	pdf	\N	rendCalChileAnchoZac.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
96	SÃ­ntomas asociados con la infecciÃ³n por curtovirus y fitoplasmas en chile para secado.	Symptoms associated with infection by curtoviruses and phytoplasmas in chile drying.	2014	cientifica	pdf	\N	sinInfCutFitoChile.pdf	\N	\N	391	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
97	Trampeo de adultos de Circulifer spp en Zacatecas.	Trapping adult Circulifer spp in Zacatecas.	2014	cientifica	pdf	\N	trampeoCirculifersppZac.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
98	TransmisiÃ³n de fitoplasmas por el vector Circulifer Tenellus en diferentes hospederos vegetales.	Phytoplasma transmission by the vector Circulifer tenellus in different plant hosts.	2014	cientifica	pdf	\N	transFitoCirculifersppVegetales.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
99	UtilizaciÃ³n experimental de Beauveria Bassiana como control biolÃ³gico de Circulifer Tenellus: vector de fitoplasmas en el cultivo de chile.	Experimental use of Beauveria Bassiana as biological control of Circulifer tenellus: vector of phytoplasmas in the pepper crop.	2014	cientifica	pdf	\N	beauveriaCotrolCirculifer.pdf	\N	\N	400	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
100	ValidaciÃ³n de una estrategia metodolÃ³gica para la evaluaciÃ³n cualitativa de un pastizal mediano abierto del estado de Zacatecas.	Validation of a methodological strategy for the qualitative evaluation of semiarid rangelands in Zacatecas.	2015	cientifica	pdf	\N	valMetPazAbiertoZac.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
101	TipificaciÃ³n de un sistema integral de lecherÃ­a familiar en Zacatecas, MÃ©xico.	Typification of integrated family dairy systems in Zacatecas, Mexico.	2015	cientifica	pdf	\N	tipificacion_2015.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
102	Aplicaciones de NPK al suelo afecta la calidad y la vida de anaquel de la tuna Cristalina	Soil applications of NPK affect fruit quality and shelf-life of Cristalina cactus pear	2015	cientifica	pdf	\N	ZegbeFruits.pdf	\N	Para mayor informaciÃ³n, favor de comunicarse a los siguientes correos: zegbe.jorge@inifap.gob.mx o jzegbe@zacatecas.inifap.gob.mx	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
103	Efecto del cambio climÃ¡tico en el potencial productivo del frijol en MÃ©xico.	Effect of climate change on the productive potential of beans in Mexico.	2016	cientifica	pdf	\N	camClimPP.pdf	\N	\N	391	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
104	Ãndices de cambio climÃ¡tico en el estado de Chiapas, MÃ©xico, en el periodo 1960-2009.	Climate change indices in the state of Chiapas, Mexico, for the period 1960-2009.	2016	cientifica	pdf	\N	indiceCClimChiap.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
105	RegionalizaciÃ³n del cambio climÃ¡tico en MÃ©xico.	Regionalization of climate change in Mexico.	2016	cientifica	pdf	\N	regionCClimMex.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
106	Infestacion natural de Bactericera cockerelli SULC, en colectas de chile para secado ancho y Mirasol en Zacatecas, MÃ©xico.	Natural infestation of Bactericera cockerelli Sulc in dry chile pepper accessions from the Ancho and Mirasol types in Zacatecas, Mexico.	2015	cientifica	pdf	\N	infestSULCZac.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
107	Presencia de virus de ARN en plantas de chile para secado con sintomas especificos.	Presence of RNA viruses in dried chile pepper with specific symptoms.	2015	cientifica	pdf	\N	ARNChileSin.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
108	Presencia y evaluacion de daÃ±o causado por Meloidogyne spp. En plantas de Chile para secado y maleza en Zacatecas, Mexico.	Presence and damage evaluation caused by Meloidogyne spp. In dry chile pepper plants in Zacatecas, Mexico.	2015	cientifica	pdf	\N	danoMeloidogyne.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
109	Reaccion de materiales comerciales de chile a enfermedades en parcelas demostrativas en Durango y Michoacan, Mexico.	Reaction of commercial pepper materials to diseases in demonstrative fields in Durango and Michoacan, Mexico.	2015	cientifica	pdf	\N	enfParcelasDemoDgoMicho.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
110	Candidatus Phytoplasma trifolii (16SrVI) en chile mirasol (Capsicum annuun L.) Cultivado en Zacatecas, MÃ©xico.	Candidatus Phytoplasma trifolii (16SrVI) in mirasol chili pepper (Capsicum annuun L.) Cultivated in Zacatecas, MÃ©xico.	2015	cientifica	pdf	\N	CanPhytoplasmaCHMirasol.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
111	Influencia de la poda sobre el crecimiento del fruto de durazno bajo condiciones de riego y temporal.	Influence of pruning on peach fruit growth under irrigation and rainfed conditions.	1988	cientifica	pdf	\N	influPodaCDurazno.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
112	Diferencias entre clones de durazno en la respuesta estomÃ¡tica en condiciones de invernadero.	Differences among seedling peach clones in stomatal response under greenhouse conditions.	1993	cientifica	pdf	\N	difClonDurazno.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
113	EvaluaciÃ³n de cianamida hidrogenada como retardante de la brotaciÃ³n de yemas florales de duraznero criollo.	Evaluation of hydrogen cyanamide as delayer of floral bud break of criollo peaches.	1993	cientifica	pdf	\N	hidroYemasFlorDuraznoC.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
114	Retraso de la floraciÃ³n de durazno Flordaking con aplicaciones de etofÃ³n en otoÃ±o.	Blooming delaying of Flordaking peaches with ethephon applications in autumn	1994	cientifica	pdf	\N	retFloracionDuraznoOt.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
115	Diferencias en la Ã©poca de la floraciÃ³n entre clones de Durazno.	Blooming time differences among seedling peach clones.	1994	cientifica	pdf	\N	difFloracionClonDurazno.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
116	Influencia de la Ã©poca de plantaciÃ³n, fertilizaciÃ³n y poda de trasplante sobre el desarrollo inicial del durazno criollo bajo temporal.	Influence of plating season, fertilization and pruning at planting time on the initial peach tree growth under rainfed conditions.	1995	cientifica	pdf	\N	infPlantacionDuraznoCriolloBajoTemp.pdf	\N	\N	390	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
117	FenologÃ­a del duraznero criollo en Jerez, Zacatecas, MÃ©xico: Un modelo y cÃ³digo decimal fenolÃ³gico.	Phenology of native peach in Jerez, Zacatecas, Mexico.	1995	cientifica	pdf	\N	DuraznoCriolloJerez.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
118	Respuesta del rendimiento del duraznero Prunus persica L. Batsch criollo mexicano a la maleza y fertilizaciÃ³n con NPK.	Yield and economical response of mexican native peach Prunus pÃ©rsica L. Batsch to weed and NPK fertilization.	1996	cientifica	pdf	\N	rendDurazneroMalezaNPK.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
119	Potencial de rendimiento y asimilaciÃ³n de CO2 en Ã¡rboles jÃ³venes de durazno y nectarino.	Yield potential and net CO2 asimilation in nonfruting peach and nectarine tres.	1998	cientifica	pdf	\N	potCO2DuraznoJoven.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
120	Influencia de la poda en melocotonero cultivado bajo secano en el trÃ³pico mexicano.	Influence of pruning in clingstone peaches cultivated under rainfed conditions.	1998	cientifica	pdf	\N	infPodaMelocotonero.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
121	Uso de un Sistema de informaciÃ³n geogrÃ¡fico GIS para identificar Ã¡rea apropiadas para la producciÃ³n de durazno.	Use of a geographical information system GIS to describe suitable production areas for peach.	1998	cientifica	pdf	\N	GisAreasDurazno.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
122	Un estudio de poda en durazno criollo en bajas latitudes.	A study of pruning on seedling peaches at low latitude.	1998	cientifica	pdf	\N	estudioPodaDuraznoLatitudBaja.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
123	El riego parcial de la raÃ­z adelanta la maduraciÃ³n de la Manzana Royal Gala.	Partial rootzone drying advances fruit maturity of Royal Gala Apple.	2016	cientifica	pdf	\N	riegoMadManzRoyal.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
124	Ocurrencia y deteccion molecular de spiroplasma citri en zanahorias y su insecto vector, circulifer tenellus en MÃ©xico.	Occurrence and molecular detection of spiroplasma citri in carrots and its insect vector, circulifer tenellus, in mexico.	2016	cientifica	pdf	\N	occFitZana.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
125	Primer reporte confirmado del iris yellow spot virus en almacigos de cebolla en Zacatecas, MÃ©xico.	First Confirmed Report of Iris yellow spot virus in Onion Nurseries in Zacatecas, Mexico.	2016	cientifica	pdf	\N	iYellCebZac.pdf	\N	Para mayor informaciÃ³n, favor de comunicarse al siguiente correo: velasquez.rodolfo@inifap.gob.mx.	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
126	Efecto del tratamiento tÃ©rmico sobre la presencia de virus en bulbos de ajo Allium sativum L.	Effect of thermic treatment on the presence of virus in garlic Allium sativum L bulbs.	2016	cientifica	pdf	\N	efeVirusBulbosAjo.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
127	Primer reporte de una cepa relacionada con Candidatus Phytoplasma trifolii asociada a una nueva enfermedad en plantas de tomate en Zacatecas, MÃ©xico.	First report of Candidatus Phytoplasma trifolii-related strain associated with a new disease in tomato plants in Zacatecas, Mexico.	2016	cientifica	pdf	\N	pInfoCanT.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
128	Calidad de vida laboral de jornaleros dedicados a la producciÃ³n de tomate fresco bajo invernadero.	Quality of worklife of workers dedicated to fresh tomato production under greenhouse.	2016	cientifica	pdf	\N	RevCubanaSaludTrabajo.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
129	Efecto de agentes de manejo alternativo sobre el desarrollo de pudriciÃ³n blanca de ajo.	Effect of agents of alternative management on the garlic white rot development.	2016	cientifica	pdf	\N	agMaPuBajo.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
130	DetecciÃ³n del virus de la mancha amarilla del iris en almÃ¡cigos de cebolla en Zacatecas, MÃ©xico.	Detection of the yellow spot virus in onion seedlings in Zacatecas, Mexico	2017	cientifica	pdf	\N	IYSV.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
131	CaracterizaciÃ³n forrajera de ecotipos de zacate buffel en condiciones de temporal en Debre Zeit, Etiopia.	Forage characterization of ecotypes of buffel grass under temporary conditions in Debre Zeit, Ethiopia	2017	cientifica	pdf	\N	buffel2017.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
132	GÃ©neros de Chicharritas Presentes durante el Invierno en Regiones de Aguascalientes, Coahuila, y Zacatecas, MÃ©xico	Presence of leafhoppers during the winter in regions of Aguascalientes, Coahuila, and Zacatecas, Mexico.	2017	cientifica	pdf	\N	velsquezvalle2017.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
133	Sistema para programar y calendarizar el riego de los cultivos en tiempo real.	System to program and schedule the irrigation of crops in real time.	2017	cientifica	pdf	\N	sisProgCalRiego.pdf	\N	\N	392	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
134	Cambios estacionales y concentraciÃ³n de nutrientes en cladodios del nopal tunero Cristalina en respuesta a la fertilizaciÃ³n con NPK.	Seasonal changes and nutrient concentrations of Cristalina cactus pear cladodes in response to NPK fertilization.	2017	cientifica	pdf	\N	camCristalina.pdf	\N	jzegbe@zacatecas.inifap.gob.mx	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
135	Sistema de producciÃ³n de forrajes de temporal y pastoreo de cabras: OpciÃ³n para la reconversiÃ³n productiva.	Rainfed forage production system and goat grazing: an option for productive conversion.	2015	cientifica	pdf	\N	Rainfedproduction.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
136	Tillandsia recurvata y su valor quÃ­mico como un uso alternativo para la alimentaciÃ³n de rumiantes en el norte de MÃ©xico.	Tillandsia recurvata and its chemical value as an alternative use for feeding ruminants in northern Mexico.	2017	cientifica	pdf	\N	TillandsiaRecurvata.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
137	AdopciÃ³n tecnolÃ³gica de surcos-doble hilera con pileteo en cebada maltera.	Technology adoption of double line seeding on a row with basin planting system in malting barley,	2017	cientifica	pdf	\N	2052-10081-2-PB.pdf	\N	\N	392	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
138	Primer reporte del fitoplasma agente de la virescencia transmitida por la chicharrita del betabel en Capsicum annuum y Circulifer tenellus en MÃ©xico.	First report of beet leafhopper transmitted virescence agent phytoplasma in Capsicum annuum and Circulifer tenellus in MÃ©xico.	2017	cientifica	pdf	\N	pRepFito.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
139	Calidad de forraje de canola (Brassica napus L.) en floraciones temprana y tardÃ­a bajo condiciones de temporal en Zacatecas, MÃ©xico.	Forage quality of canola (Brassica napus L.) at early and late bloom under rainfed conditions in Zacatecas, Mexico.	2017	cientifica	pdf	\N	Art_Canola.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
140	Future climate scenarios project a decrease in the risk of fall armyworm outbreaks	\N	2017	cientifica	pdf	\N	\N	\N	Para mayor informaciÃ³n, favor de comunicarse al siguiente correo: ramirez.nadiezhda@inifap.gob.mx	364	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
141	Global alterations in areas of suitability for maize production from climate change and using a mechanistic species distribution model (CLIMEX).	Global alterations in areas of suitability for maize production from climate change and using a mechanistic species distribution model (CLIMEX).	2017	cientifica	pdf	\N	20307ART03 A Nadiezhda.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
142	Eficiencia en el uso del agua de variedades de alfalfa Medicago sativa L. con sistema de riego subsuperficial.	Water use efficiency of alfalfa varieties Medicago sativa L. with subsurface irrigation system.	2017	cientifica	pdf	\N	Alfalfa.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
143	Barretero: nueva variedad de ajo jaspeado para Zacatecas.	Barretero: new variety of jaspeado garlic for Zacatecas.	2017	cientifica	pdf	\N	barrteroAjoJasZac.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
144	Preferencia del agricultor por las semillas mejoradas de maÃ­z en Chiapas, MÃ©xico: Un enfoque de experimento de elecciÃ³n.	Farmer preference for improved corn seeds in Chiapas, Mexico: A choice experiment approach.	2017	cientifica	pdf	\N	20310ART01A.pdf	\N	\N	404	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
145	PatÃ³genos comunes de semilla de ajo en Aguascalientes y Zacatecas, MÃ©xico.	Common pathogens of garlic seed in Aguascalientes and Zacatecas, Mexico.	2017	cientifica	pdf	\N	patComAguZac.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
146	DetecciÃ³n de patÃ³genos asociados con psÃ­lidos y chicharritas en Capsicum annuum L. en los estados mexicanos de Durango, Zacatecas y MichoacÃ¡n.	Detection of Pathogens Associated with Psyllids and Leafhoppers in Capsicum annuum L. in the Mexican States of Durango, Zacatecas and Michoacan.	2018	cientifica	pdf	\N	Plant Disease 2018.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
147	Un modelo empÃ­rico para predecir el rendimiento de frijol de secano con datos de varios aÃ±os.	An empirical model to predict yield of rainfed dry bean with multi-year data	2007	cientifica	pdf	\N	empiricalModel.pdf	\N	\N	410	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
148	Climatic Adaptation and Ecological Descriptors of 42 Mexican Maize Races.	Climatic Adaptation and Ecological Descriptors of 42 Mexican Maize Races.	2008	cientifica	pdf	\N	climAdaEcoMaize.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
149	Mapeo del Ã­ndice de aridez y su distribuciÃ³n poblacional en MÃ©xico.	Mapping of the aridity index and its population distribution in Mexico.	2011	cientifica	pdf	\N	mapeoAridez.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
150	Spatial Variability of the Hurst Exponent for the Daily Scale Rainfall Series in the State of Zacatecas, Mexico.	Spatial Variability of the Hurst Exponent for the Daily Scale Rainfall Series in the State of Zacatecas, Mexico.	2013	cientifica	pdf	\N	spatialVariability.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
151	Land Use/Cover and Productivity in the Compact Agricultural Areas of Mexico.	Land Use/Cover and Productivity in the Compact Agricultural Areas of Mexico.	2014	cientifica	pdf	\N	compactAgricultureAreas.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
152	Impacto del cambio climÃ¡tico sobre la estaciÃ³n de crecimiento en el estado de Jalisco, MÃ©xico.	Impacto del cambio climÃ¡tico sobre la estaciÃ³n de crecimiento en el estado de Jalisco, MÃ©xico.	2016	cientifica	pdf	\N	iImpactoCCCrecimiento.pdf	\N	\N	390	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
153	Ãreas potenciales para plantaciones forestales ante escenarios de cambio climÃ¡tico en el estado de Jalisco, MÃ©xico.	Potential areas for forest plantation for climate change scenarios in the state of Jalisco, MÃ©xico.	2017	cientifica	pdf	\N	apotencialesCCJalisco.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
154	Cambios esperados al uso del suelo en MÃ©xico, segÃºn escenario de cambio climÃ¡tico A1F1.	Expected changes in land use in Mexico, according to the climate change scenario A1F1.	2017	cientifica	pdf	\N	cambiosSueloCC.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
155	El cambio climÃ¡tico afecta el nÃºmero de horas de los rangos tÃ©rmicos del chile en el norte-centro de MÃ©xico.	Climate change affects the number of hours in the termal ranges of chilli in North-Central Mexico.	2017	cientifica	pdf	\N	CChorasRTChile.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
156	Escenarios de cÃ³mo el cambio climÃ¡tico modificarÃ¡ las zonas productoras de aguacate Hass en MichoacÃ¡n.	Scenarios of how climate change will modify the Hass avocado producing areas in MichoacÃ¡n.	2017	cientifica	pdf	\N	escenariosCCAguacate.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
157	Sistema de informaciÃ³n agroclimÃ¡tica para MÃ©xico-CentroamÃ©rica.	Agroclimatic information system for Mexico-Central America.	2018	cientifica	pdf	\N	sisInfoMexCari.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
158	Galletas elaboradas con harina de avena y frijol comÃºn mejoraron los marcadores sÃ©ricos en ratas diabÃ©ticas.	Cookies elaborated with oat and common bean flours improved serum markers in diabetic rats.	2018	cientifica	pdf	\N	perez-ramirez et al. 2018.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
159	EcogeografÃ­a del teosinte.	Ecogeography of teosinte.	2018	cientifica	pdf	\N	Ecogeographyofteosinte.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
160	HNMR-based metabolomic profiling for identification of metabolites in Capsicum annuum cv. mirasol infected by beet mild curly top virus (BMCTV).	HNMR-based metabolomic profiling for identification of metabolites in Capsicum annuum cv. mirasol infected by beet mild curly top virus (BMCTV).	2018	cientifica	pdf	\N	drbecerra.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
161	Necrosis foliar; nuevo sÃ­ntoma asociado a la pudriciÃ³n de la raÃ­z de chile (Capsicum annuum) en Durango y Zacatecas, MÃ©xico.	Foliar necrosis; new symptom associated to root rot of pepper (Capsicum annuum) in Durango and Zacatecas, Mexico.	2017	cientifica	pdf	\N	necrosisFoliar.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
162	Crecimiento y producciÃ³n de forraje de canola (brassica napus l.) de otoÃ±o-invierno en Zacatecas, MÃ©xico.	Growth and production of autumn-winter canola (brassica napus l.) forage in Zacatecas, Mexico.	2018	cientifica	pdf	\N	cCanolaForraje.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
163	CaracterizaciÃ³n morfolÃ³gica de un rebaÃ±o de conservaciÃ³n de cabras criollas en Zacatecas, MÃ©xico.	Morphological characterization of a native goat conservation herd in Zacatecas, MÃ©xico.	2018	cientifica	pdf	\N	cMorfoCabras.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
164	Microorganismos asociados con la pudriciÃ³n de corona de alfalfa en el norte centro de MÃ©xico	Microorganisms associated with alfalfa crown rot in north central Mexico	2018	cientifica	pdf	\N	CrownrotRMF.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
165	Opciones de riego para ahorrar agua y mejorar el tamaÃ±o de las frutas de exportaciÃ³n y capacidad de almacenamiento de la tuna Roja Lisa	Irrigation options to save water while enhancing export-size fruit and storability of Smooth Red cactus pear	2018	cientifica	pdf	\N	JSciFoodAgric_98_5503_2018.pdf	\N	Para solicitar una copia del articulo envÃ­e un correo a zegbe.jorge@inifap.gob.mx	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
166	First Report of Candidatus Phytoplasma trifoliiâRelated Strain Associated with a New Disease on Garlic in Zacatecas, Mexico.	First Report of 'Candidatus Phytoplasma trifolii'âRelated Strain Associated with a New Disease on Garlic in Zacatecas, Mexico	2018	cientifica	pdf	\N	Reveles-Torres-2018-First report of Candidatu.pdf	\N	\N	395	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
167	First Report of the Leafhoppers Ceratagallia nitidula and Empoasca abrupta (Hemiptera: Cicadellidae) as Vectors of Candidatus Phytoplasma trifolii.	First Report of the Leafhoppers Ceratagallia nitidula and Empoasca abrupta (Hemiptera: Cicadellidae) as Vectors of Candidatus Phytoplasma trifolii.	2018	cientifica	pdf	\N	Salas-Muñoz-2018-First report of the leafhoppe.pdf	\N	\N	399	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
168	Candidatus Phytoplasma trifolii (16SrVI) infection modifies the polyphenols concentration in pepper (Capsicum annuum) plant tissues.	Candidatus Phytoplasma trifolii (16SrVI) infection modifies the polyphenols concentration in pepper (Capsicum annuum) plant tissues.	2018	cientifica	pdf	\N	Reveles–Torres-2018-Candidatus Phytoplasma tri.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
169	VariaciÃ³n estacional de la concentraciÃ³n foliar de nutrimentos en huertas de higuera bajo sistemas de producciÃ³n intensiva.	Seasonal variation of the foliar concentration of nutrients in fig orchards under intensive production systems.	2019	cientifica	pdf	\N	RevMexCA_10_3-525-536.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
170	DisminuciÃ³n de las horas frÃ­o como efecto del cambio climÃ¡tico en MÃ©xico.	\N	2019	cientifica	pdf	\N	disHorasFrio.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
171	Cold hours decrease as a result of climate change in Mexico	Cold hours decrease as a result of climate change in Mexico	2019	cientifica	pdf	\N	2019-Cold hours decrease as a result of climate change in Mexico.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
172	Efecto del calentamiento global sobre la producciÃ³n de alfalfa en MÃ©xico	\N	2020	cientifica	pdf	\N	2020 Efecto del calentamiento global sobre la producción de alfalfa en México.pdf	\N	\N	390	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
173	Global warming effect on alfalfa production in Mexico	Global warming effect on alfalfa production in Mexico	2020	cientifica	pdf	\N	2020 Global warming effect on alfalfa production in Mexico.pdf	\N	\N	397	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
174	Efecto en la erosiÃ³n hÃ­drica del suelo en pastizales y otros tipos de vegetaciÃ³n	\N	2020	cientifica	pdf	\N	2020 Efecto en la erosión hídrica del suelo en pastizales y otros tipos de vegetación.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
175	Effects of rainfall pattern changes due to global warming on soil water erosion	Effects of rainfall pattern changes due to global warming on soil water erosion	2020	cientifica	pdf	\N	2020 Effects of rainfall pattern changes due to global warming on soil water erosion.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
176	Aumento del nÃºmero de generaciones de gusano cogollero (Spodoptera frugiperda) como indicador del calentamiento global	Increase of the number of broods of Fall Armyworm (Spodoptera frugiperda) as an indicator of global warming	2020	cientifica	pdf	\N	2020-Increase of the number of broods of Fall Armyworm.pdf	\N	\N	399	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
177	Relationship between precipitation anomalies and multivariate ENSO index through wavelet coherence analysis	\N	2020	cientifica	pdf	\N	relationshiPre.pdf	\N	\N	385	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
178	Influencia del cambio climÃ¡tico en los requerimientos tÃ©rmicos del nopal tunero (Opuntia spp.) en el Centro-Norte de MÃ©xico	Influence of climate change on thermal requirements of cactus pear (Opuntia spp.) in Central-Northern of Mexico	2021	cientifica	pdf	\N	CCnopalo.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
179	Â¿Por quÃ© MÃ©xico es un paÃ­s altamente vulnerable al cambio climÃ¡tico?	\N	2021	cientifica	pdf	\N	MexicoVulnera.pdf	\N	\N	410	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
180	Why is Mexico highly vulnerable to climate change	Why is Mexico highly vulnerable to climate change	2021	cientifica	pdf	\N	WhyMexico.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
181	Especificacion de Problemas identificados en un diagnostico agricola: Caso del abatimiento del acuifero.	Specifications of problems identified in Agricultural Fiagnosis: Case of the Lowering of the Ground water Level.	1989	cientifica	pdf	\N	diagAcuiferos.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
182	EvaluaciÃ³n Intermedia del Impacto de la IntervenciÃ³n TecnolÃ³gica en Unidades Agropecuarias.	Intermediate Evaluation of the Impact of Technological Intervention in Agricultural Units.	1992	cientifica	pdf	\N	evaImUniAgro.pdf	\N	\N	386	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
183	ComercializaciÃ³n de Carne de Caprinos en el Estado de Zacatecas, MÃ©xico.	Marketing of Goat Meat in the State of Zacatecas, Mexico.	1994	cientifica	pdf	\N	comCapriZac.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
184	Comportamiento productivo y valor nutricional de veza comÃºn Vicia Sativa I durante otoÃ±o-invierno en Zacatecas, MÃ©xico	\N	2020	cientifica	pdf	\N	20303ART01 A RSan.pdf	\N	\N	388	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
217	DiagnÃ³stico de los recursos naturales para la planeaciÃ³n de la investigaciÃ³n tecnolÃ³gica y el ordenamiento ecolÃ³gico	\N	2009	tecnica	pdf	diagRecursosN.jpg	diagRecN.pdf	\N	\N	325	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
185	Aumento del nÃºmero de generaciones de gusano cogollero (Spodoptera frugiperda) como indicador del calentamiento global	Increase of the number of broods of Fall Armyworm (Spodoptera frugiperda) as an indicator of global warming	2020	cientifica	pdf	\N	20307ART02 A Nad.pdf	\N	\N	384	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
186	CaracterizaciÃ³n morfologica de genotipos de pasto buffel con potencial para producciÃ³n de forraje y semilla	Morphological characterization of buffelgrass with potential for forage and seed production	2020	cientifica	pdf	\N	20309ART01 A RSan.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
187	Cladode Pruning Affects Yield and Fruit Quality of Roja Lisa Cactus Pear Opuntia ficus-indica L. Mill.: A Preliminary Study	\N	2020	cientifica	pdf	\N	20312ART01 A Jzeg.pdf	\N	\N	395	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
188	La siembra de maÃ­z en doble hilera no mejora la producciÃ³n y calidad del forraje de la variedad cafime en Zacatecas.	Maize planting in twin row does not affect the quality and forage production of cafime variety in Zacatecas	2020	cientifica	pdf	\N	20312ART02 A RSan.pdf	\N	\N	407	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
189	First report of candidatus phytoplasma trifolii- related strain associated with flower abortion and necrosis in prickly pear cactus in Zacatecas, Mexico	\N	2020	cientifica	pdf	\N	20312ART03 A LRev.pdf	\N	\N	382	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
190	Efecto posible del cambio climÃ¡tico sobre la demanda de agua de cultivos importantes en Zacatecas	Potential climate change effect on water demand of important crops in Zacatecas	2022	cientifica	pdf	\N	CCDemandaAgua.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
191	Impacto del cambio climÃ¡tico sobre los requerimientos tÃ©rmicos y nÃºmero de generaciones de mosquita blanca (Bemicia tabaci) en el norte centro de MÃ©xico	Climate change effects on thermal requirements and number of broods of whitefly (Bemicia tabaci) in the north-central region of Mexico	2022	cientifica	pdf	\N	CCMosquitBlanca.pdf	\N	\N	394	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
192	PredicciÃ³n de la producciÃ³n y rendimiento de frijol, con modelos de redes neuronales artificiales y datos climÃ¡ticos	Prediction of production and yield of beans, with models of artificial neural networks and climate data	2022	cientifica	pdf	\N	PredFrijolMod.pdf	\N	\N	398	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
193	Riego suplementario en finca de tuna Roja Lisa: Efectos antes y despuÃ©s de la cosecha	On-Farm Supplemental Irrigation of "Roja Lisa" Cactus Pear: Pre- and Postharvest Effects	2022	cientifica	pdf	\N	IrrigaRojaLisa.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
194	Flooded Extent and Depth Analysis Using Optical and SAR Remote Sensing with Machine Learning Algorithms	\N	2022	cientifica	pdf	\N	Flooded Extent and Depth Analysis.pdf	\N	\N	389	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
195	Sensitivity of the RDI and SPEI Drought Indices to Different Models for Estimating Evapotranspiration Potential in Semiarid Regions	\N	2022	cientifica	pdf	\N	Sensitivity of the RDI and SPEI Drought Indices.pdf	\N	\N	387	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
196	Spatiotemporal Uncertainty and Sensitivity Analysis of the SIMPLE Model Applied to Common Beans for Semi-Arid Climate of Mexico	\N	2022	cientifica	pdf	\N	Spatiotemporal Uncertainty and Sensitivity Analysis.pdf	\N	\N	397	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
197	Efecto de fertilizaciÃ³n foliar en el rendimiento e Ã­ndice de cosecha en cinco variedades de frijol bajo riego	Foliar fertilization effect on yield and harvest index from five varieties of bean under irrigated conditions	2019	cientifica	pdf	\N	fertFrijol.pdf	\N	\N	396	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
198	Variedades de frijol pinto, una alternativa para mitigar los efectos del cambio climÃ¡tico en el noroeste de Zacatecas	Varieties of pinto beans, an alternative to mitigate the effects of climate change in northwest Zacatecas	2021	cientifica	pdf	\N	varPinto.pdf	\N	\N	391	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
199	Potencial Productivo de Especies Forrajeras en Zacatecas	\N	2001	tecnica	pdf	PPForrajes.jpg	Pot_Prod_de_Especies_Forrajeras_en_Zacatecas.pdf	\N	\N	370	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
200	Potencial Productivo de Especies Agricolas en Zacatecas	\N	2003	tecnica	pdf	PPAgricolas.jpg	Pot_Prod_de_Especies_Agricolas_en_Zacatecas.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
201	La siembra en surcos y corrugaciones con pileteo	\N	2004	tecnica	pdf	portadita_siembra_en_surcos.jpg	LA_SIEMBRA_EN_SURCOS_Y_CORRUGACIONES_CON_PILETEO.pdf	\N	\N	340	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
202	EstadÃ­sticas ClimatolÃ³gicas BÃ¡sicas del Estado de Zacatecas. (PerÃ­odo 1961-2003)	\N	2004	tecnica	pdf	Portadita_2.jpg	climaZacatecas.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
203	Red de Monitoreo AgroclimÃ¡tico del Estado de Zacatecas	\N	2005	tecnica	pdf	Portadita.jpg	Red_de_monitoreo_agroclimatico.pdf	\N	\N	340	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
204	PrÃ¡cticas culturales para producir Durazno Criollo en Zacatecas	\N	2005	tecnica	pdf	duraznoGIF.gif	PracticasDurazno2005.pdf	\N	\N	353	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
205	ModificaciÃ³n de la floraciÃ³n, maduraciÃ³n y Ã©poca de cosecha de nopal tunero	\N	2006	tecnica	pdf	Portadita-floracion-nopal.jpg	FrutaTunaFueraTemporada.pdf	\N	\N	398	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
206	SEQUÃA: Vulnerabilidad impacto y tecnologÃ­a para afrontarla en el Norte Centro de MÃ©xico 2a Ed	\N	2006	tecnica	pdf	SEQUIA_2aEd.jpg	SEQUIA_Vulnerabilidad_impacto_y_tecnologia_para_afrontarla_en_el_Norte_Centro_de_Mexico_2aEd.pdf	\N	\N	325	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
207	DegradaciÃ³n fÃ­sica de los suelos de pastizales bajo pastoreo continuo en el Altiplano de Zacatecas	\N	2007	tecnica	pdf	Degradacion_fisica_de_los_suelos.jpg	Degradacion_fisica_de_los_suelos.pdf	\N	\N	326	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
208	Cadena de sistemas agroalimentarios de chile seco, durazno y frijol en el Estado de Zacatecas	\N	2004	tecnica	pdf	Cadenas_Zacatecas.jpg	Cadenas_Zacatecas.pdf	\N	\N	370	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
209	Despunte de ramas mixtas y raleo de fruta en durazno "Victoria"	\N	2007	tecnica	pdf	duraznopoda.jpg	DuraznoPoda.pdf	\N	\N	351	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
210	Tecnologia de produccion de Chile Seco	\N	2006	tecnica	pdf	Tecnologia_de_produccion_de_chile_seco.jpg	Tecnologia_de_produccion_de_chile_seco.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
211	Potencial productivo de especies agrÃ­colas en el distrito de desarrollo rural RÃ­o Grande, Zacatecas	\N	2007	tecnica	pdf	Potencial_Productivo_de_Especies_Agricolas_DDR_Rio_Grande.jpg	Potencial_Productivo_de_Especies_Agricolas_DDR_Rio_Grande.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
212	Uso de estaciones meteorolÃ³gicas en la agricultura	\N	2008	tecnica	pdf	uso_de_estaciones.gif	Uso_de_estaciones_meteorologicas_en_la_agricultura.pdf	\N	\N	429	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
213	Veza comÃºn y Lathyrus sativus L: Alternativas para producir forraje en Zacatecas	\N	2007	tecnica	pdf	Veza-lathyrus.jpg	Veza_lathyrus.pdf	\N	\N	324	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
214	Probabilidad de ocurrencia de heladas en el estado de Zacatecas	\N	2008	tecnica	pdf	heladas.jpg	probHeladas.pdf	\N	\N	350	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
215	Riego parcial de la raÃ­z: Una alternativa para mejorar la productividad y ahorro de agua en manzano	\N	2009	tecnica	pdf	rprManz.jpg	RPRmanzano.pdf	\N	\N	324	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
216	Potencial Productivo de especies Agricolas en el distrito de desarrollo rural Zacatecas, Zacatecas.	\N	2009	tecnica	pdf	potZac.jpg	PotencialProdZac.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
218	TecnologÃ­a para cultivar ajo en zacatecas	\N	2009	tecnica	pdf	tecnoAjo.jpg	Tecnologia para cultivar ajo en Zac.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
219	Recomendaciones para el manejo de agalla de la Corona y enfermedades virales de la vid en Zacatecas	\N	2009	tecnica	pdf	folletoVid.jpg	recDemanejoA.pdf	\N	\N	357	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
220	El virus de la marchitez manchada del jitomate	\N	2009	tecnica	pdf	mJito.jpg	virusMarchitezjito.pdf	\N	\N	473	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
221	Produccion de plantula de chile en invernadero	\N	2010	tecnica	pdf	pantulaChila.jpg	prcChileInv.pdf	\N	\N	376	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
222	El Virus de la mancha amarilla del iris	\N	2010	tecnica	pdf	virusIris.jpg	virusManchairis.pdf	\N	\N	344	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
223	Descripcion Fenotipica de material genetico de Durazno para Zacatecas	\N	2009	tecnica	pdf	portadaD.jpg	dfDurazno.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
224	Enfermedades bÃ³ticas del ajo y chile en Aguascalientes y Zacatecas	\N	2009	tecnica	pdf	Enfermedades de Ajo y Chile.jpg	Enfermedades de Ajo y Chile.pdf	\N	\N	400	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
225	EvaluaciÃ³n del impacto econÃ³mico, social y ambiental del proyecto manejo integral de huertos de durazno en el estado de Zacatecas.	\N	2010	tecnica	pdf	Huertosmodelos.jpg	Huertosmodelos.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
226	Manejo Integrado de plagas y enfermedades de frijol en Zacatecas	\N	2010	tecnica	pdf	PlagasFrijol.jpg	PlagasFrijol.pdf	\N	\N	527	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
227	EvaluaciÃ³n del entorno para la innovaciÃ³n tecnolÃ³gica en zacatecas: identificaciÃ³n de las cadenas productivas relevantes	\N	2010	tecnica	pdf	Cadenasproductivas.jpg	CadenasProductivas.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
228	Enfermedades provocadas por virus en el cultivo de ajo en el norte centro de MÃ©xico	\N	2010	tecnica	pdf	Enfermedadesajo.jpg	Enfermedadesajo.pdf	\N	\N	347	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
229	Factores que influye en la vida de anaquel de la TUNA (Opuntia spp.) Un estudio exploratorio	\N	2010	tecnica	pdf	folletoTuna.jpg	portadaTuna.pdf	\N	\N	326	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
230	Produccion y ensilaje de Maiz Forrajero de riego	\N	2010	tecnica	pdf	folletoMaiz.jpg	FolletoMaiz.pdf	\N	\N	356	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
231	Guia para la produccion de CANOLA en Zacatecas	\N	2010	tecnica	pdf	PortadaCanola.png	FolletoCanola.pdf	\N	\N	431	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
232	Virus de frijol en la Comarca Lagunera y Zacatecas	\N	2010	tecnica	pdf	portadaVFrijol.jpg	VFrijol.pdf	\N	\N	362	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
233	Botana a base de frijol con alto valor nutricional y nutraceutico	\N	2010	tecnica	pdf	portadaFrijol.jpg	Frijol.pdf	\N	\N	342	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
234	Adelanto de cosecha e incremento de rendimiento en chile tipo Ancho mediante trasplante de plÃ¡ntulas de edad avanzada	\N	2011	tecnica	pdf	rendimientoChile.png	rendimientoChile.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
235	CEZAC 06: Variedad de ajo jaspeado para la regiÃ³n norte centro de MÃ©xico	\N	2011	tecnica	pdf	cezac06ajo.png	cezac06ajo.pdf	\N	\N	353	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
236	SituaciÃ³n actual y agenda de trabajo para la innovaciÃ³n tecnolÃ³gica del sistema producto vid en Zacatecas	\N	2010	tecnica	pdf	vidActual.png	vidActual.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
237	ProducciÃ³n de panquÃ© y barritas, alimentos de la panificaciÃ³n preparados con harina compuesta de frijol, trigo y avena	\N	2011	tecnica	pdf	panqueYBarritas.jpg	panqueYBarritas.pdf	\N	\N	337	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
238	Manual elaboraciÃ³n de productos agroindustriales de frijol	\N	2011	tecnica	pdf	manualFrigol.jpg	manualFrigol.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
239	AplicaciÃ³n de envolturas comestibles a base de MucÃ­lago de Nopal para extender la vida de anaquel de frutas perecederas	\N	2012	tecnica	pdf	mdeNopal.jpg	mdeNopal.pdf	\N	\N	336	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
240	Proceso de la ElaboraciÃ³n de Dulce de Tuna	\N	2010	tecnica	pdf	procElaDTuna.jpg	procElaDTuna.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
241	La Jatropha (Jatropha curcas L.) en Zacatecas	\N	2010	tecnica	pdf	Jatropha.png	Jatropha.pdf	\N	\N	344	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
242	AdopciÃ³n de la tecnologÃ­a "siembra en surcos doble hilera y pileteo" en cebada maltera en el estado de Zacatecas. Un anÃ¡lisis del proceso y los impactos.	\N	2011	tecnica	pdf	AdoSurcoDH.png	AdoSurcoDH.pdf	\N	\N	339	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
243	Licor de Durazno.	\N	2011	tecnica	pdf	licDurazno.png	licDurazno.pdf	\N	\N	354	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
244	Ate de Durazno.	\N	2011	tecnica	pdf	AteDurazno.png	AteDurazno.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
245	ExtracciÃ³n y purificaciÃ³n de mucilago de nopal.	\N	2011	tecnica	pdf	extMuNopal.png	extMuNopal.pdf	\N	\N	503	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
246	Orejones de durazno deshidratados con energÃ­a solar.	\N	2011	tecnica	pdf	oreDurazno.png	oreDurazno.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
247	TÃ©cnicas para la transformaciÃ³n de leche de cabra en zonas marginales.	\N	2011	tecnica	pdf	tecLecheCabra.png	tecLecheCabra.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
248	La interacciÃ³n de un macho cabrÃ­o sexualmente activo con un tratamiento fotoperÃ­odico reduce la estacionalidad en cabras anestricas.	\N	2011	tecnica	pdf	machoCabrio.png	machoCabrio.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
249	ProducciÃ³n de forraje con cereales de grano pequeÃ±o.	\N	2011	tecnica	pdf	procForrCP.png	procForrCP.pdf	\N	\N	405	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
250	Amarillamientos del chile para secado.	\N	2011	tecnica	pdf	amaChileSecado.png	amaChileSecado.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
251	EcologÃ­a del hongo causante de la pudriciÃ³n blanca.	\N	2011	tecnica	pdf	ecoHongo.png	ecoHongo.pdf	\N	\N	367	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
252	Uso de zeolita para captura de nitrÃ³geno en estiÃ©rcol bovino	\N	2012	tecnica	pdf	usoZeolita.png	usoZeolita.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
253	ProducciÃ³n de plÃ¡ntula de chile en invernadero: Manual para el productor.	\N	2012	tecnica	pdf	plantulaChileMa.png	plantulaChileMa.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
254	MetodologÃ­a para el diseÃ±o, aplicaciÃ³n y anÃ¡lisis de encuestas sobre adopciÃ³n de tecnologÃ­as en productores rurales.	\N	2012	tecnica	pdf	encuestasRurales.png	encuestasRurales.pdf	\N	\N	325	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
255	Manejo de enfermedades virales de ajo en Zacatecas.	\N	2012	tecnica	pdf	viralesAjo.png	viralesAjo.pdf	\N	\N	353	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
256	ProducciÃ³n de chile seco con riego por goteo sub-superficial.	\N	2012	tecnica	pdf	prodChileSe.png	prodChileSe.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
257	Manejo de plantaciones de nopal tunero en el Altiplano Potosino	\N	2012	tecnica	pdf	planNopTun.png	planNopTun.pdf	\N	\N	354	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
258	ProducciÃ³n y comercializaciÃ³n del durazno criollo de Zacatecas.	\N	2012	tecnica	pdf	proComDurCriollo.png	proComDurCriollo.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
259	Avances de investigaciÃ³n sobre corteza corchosaâmadera rugosa de vid en Aguascalientes.	\N	2010	tecnica	pdf	VidAgus.jpg	VidAgus.pdf	\N	\N	337	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
260	Sistema en lÃ­nea para programaciÃ³n de riego de chile y frijol en Zacatecas.	\N	2012	tecnica	pdf	sisRieg.jpg	sisRieg.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
261	Sistema de alerta para conchuela del frijol y gusano cogollero en el estado de Zacatecas.	\N	2012	tecnica	pdf	sisPlaga.jpg	sisPlaga.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
262	AlimentaciÃ³n y manejo de bovinos en agostadero durante Ã©pocas de sequÃ­a.	\N	2012	tecnica	pdf	alimmase.jpg	alimmase.pdf	\N	\N	381	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
263	PrÃ¡cticas de restauraciÃ³n de suelos para la conservaciÃ³n del agua.	\N	2012	tecnica	pdf	ressuel.jpg	ressuel.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
264	Bancos de proteÃ­na para rumiantes en el SemiÃ¡rido Mexicano	\N	2012	tecnica	pdf	bancpro.jpg	bancpro.pdf	\N	\N	468	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
265	Carga animal del pastizal mediano abierto en zacatecas (Segundo trimestre del 2007)	\N	2007	tecnica	pdf	caan2t.jpg	caan2t.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
266	Carga animal del pastizal mediano abierto en zacatecas (Tercer trimestre del 2007)	\N	2007	tecnica	pdf	caan3t.jpg	caan3t.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
267	Carga animal del pastizal mediano abierto en zacatecas (Cuarto trimestre del 2007)	\N	2007	tecnica	pdf	caan4t.jpg	caan4t.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
268	Manejo de las principales enfermedades del chile para secado en el norte centro de MÃ©xico.	\N	2013	tecnica	pdf	EnfChilS.png	EnfChilS.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
269	SelecciÃ³n y conservaciÃ³n de semilla de chile: primer paso para una buena cosecha.	\N	2013	tecnica	pdf	semillaCH.png	semillaCH.pdf	\N	\N	326	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
270	Virus y fitoplasmas asociados con el cultivo de chile para secado en el norte centro de MÃ©xico.	\N	2013	tecnica	pdf	VFcultivoCh.png	VFcultivoCh.pdf	\N	\N	326	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
271	Presencia y manejo de los virus hoja de abanico y enrollamiento de la hoja en viÃ±edos de Aguascalientes.	\N	2013	tecnica	pdf	vhojaA.png	vhojaA.pdf	\N	\N	357	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
272	Control de Malezas con Escardas y Herbicidas Preemergentes en Frijol en Zacatecas.	\N	2004	tecnica	pdf	Control_de_Malezas.png	Control_de_Malezas.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
273	Barretero, variedad de ajo jaspeado para Zacatecas.	\N	2014	tecnica	pdf	barretero.png	barretero.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
274	Desgranadora de ajo para pequeÃ±os productores.	\N	2014	tecnica	pdf	desgranadoAjo.png	desgranadoAjo.pdf	\N	\N	353	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
275	GuÃ­a para producciÃ³n de cebolla en Zacatecas.	\N	2014	tecnica	pdf	prodCebolla.png	prodCebolla.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
276	Microsilos: Una alternativa para pequeÃ±os productores.	\N	2014	tecnica	pdf	microsilos.png	microsilos.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
277	Nuevas variedades de frijol para el estado de Zacatecas.	\N	2014	tecnica	pdf	nuevaVariedadFrijol.png	nuevaVariedadFrijol.pdf	\N	\N	401	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
278	PrÃ¡cticas agronÃ³micas para mejorar el suelo cultivado con chile Mirasol.	\N	2014	tecnica	pdf	mejoraSuelo.png	mejoraSuelo.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
279	ProducciÃ³n de semilla de frijol.	\N	2014	tecnica	pdf	produccionSemillaFrijol.png	produccionSemillaFrijol.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
280	SelecciÃ³n y almacenamiento de semilla de frijol.	\N	2014	tecnica	pdf	almacenamientoFrijol.png	almacenamientoFrijol.pdf	\N	\N	358	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
281	TipificaciÃ³n fisicoquÃ­mica y productos agroindustriales de ajos zacatecanos.	\N	2014	tecnica	pdf	fisicoquimica.png	fisicoquimica.pdf	\N	\N	339	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
282	Manejo de enfermedades de los almÃ¡cigos tradicionales de chile para secado en Zacatecas.	\N	2014	tecnica	pdf	manejoEAlmacigosChile.png	manejoEAlmacigosChile.pdf	\N	\N	409	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
283	Fitoplasmas: Otros agentes fitopatÃ³genos.	\N	2014	tecnica	pdf	aFitopatogenos.png	aFitopatogenos.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
284	Incidencia de enfermedades parasitarias de chile en el norte centro de MÃ©xico.	\N	2014	tecnica	pdf	eParaChile.png	eParaChile.pdf	\N	\N	352	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
285	Virus y fitoplasmas de chile: Una perspectiva regional.	\N	2014	tecnica	pdf	viFitoChileRegional.png	viFitoChileRegional.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
286	Variedades de Manzana recomendadas para las serranÃ­as de Hidalgo y QuerÃ©taro.	\N	2010	tecnica	pdf	vManzHQ.png	vManzHQ.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
287	Principales cultivares mexicanos de nopal tunero.	\N	2000	tecnica	pdf	pCultMNTuna.png	pCultMNTuna.pdf	\N	\N	361	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
288	Variedades mejoradas y selecciones de Durazno del INIFAP.	\N	2011	tecnica	pdf	varDurMInifap.png	varDurMInifap.pdf	\N	\N	343	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
289	Cultivo del chile en MÃ©xico, Tendencias de producciÃ³n y problemas fitosanitarios actuales.	\N	2012	tecnica	pdf	cultChprofit.png	cultChprofit.pdf	\N	\N	336	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
290	Comportamiento AgronÃ³mico del Pasto Banderilla [Bouteloua curtipendula (Michx.) Torr.] en el Altiplano de Zacatecas.	\N	2015	tecnica	pdf	banderilla.png	banderilla.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
291	Sistema de producciÃ³n de forrajes de temporal una opciÃ³n para la reconversiÃ³n productiva	\N	2014	tecnica	pdf	sproduccion14.png	sproduccion14.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
292	Candidatus Phytoplasma trifolii: Un nuevo patogeno infectando las plantas de chile para secado en Zacatecas, MÃ©xico.	\N	2015	tecnica	pdf	cptChilesecado.png	cptChilesecado.pdf	\N	\N	328	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
293	DistribuciÃ³n de vectores y virus en frutales de hueso en Aguascalientes y Zacatecas.	\N	2015	tecnica	pdf	vectoresVirusHueso.png	vectoresVirusHueso.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
294	Galletas con Harina de Frijol de alta calidad nutricional y nutraceutica.	\N	2015	tecnica	pdf	galletasHFrijol.png	galletasHFrijol.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
295	La cabra criolla en el Altiplano Potosino: Su potencial lechero y desarrollo de cabritos.	\N	2015	tecnica	pdf	cabraCriolla.png	cabraCriolla.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
296	Las enfermedades causadas por virus mÃ¡s comunes en el chile en Aguascalientes.	\N	2015	tecnica	pdf	enfVisrusAguas.png	enfVisrusAguas.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
297	ProducciÃ³n y calidad de leche de cabras criollas norte-centro de MÃ©xico manejadas bajo dos sistemas de producciÃ³n.	\N	2015	tecnica	pdf	prodCalLecheCC.png	prodCalLecheCC.pdf	\N	\N	326	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
298	MetodologÃ­a para la extracciÃ³n, identificaciÃ³n y cuantificaciÃ³n de Ã¡cidos grasos en la dieta y leche de cabras.	\N	2015	tecnica	pdf	metoAcidosGLeche.png	metoAcidosGLeche.pdf	\N	\N	356	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
299	Platero, nueva variedad de ajo Jaspeado para Zacatecas.	\N	2015	tecnica	pdf	plateroAjoZac.png	plateroAjoZac.pdf	\N	\N	370	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
300	Presencia de Candidatus Liberibacter solanacearum en Chile para secado en Durango, MÃ©xico.	\N	2015	tecnica	pdf	CLsChileSecadoDGO.png	CLsChileSecadoDGO.pdf	\N	\N	383	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
301	SelecciÃ³n de materiales promesa de frijol para el estado de Zacatecas.	\N	2015	tecnica	pdf	matPromesaFrijol.png	matPromesaFrijol.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
302	Las enfermedades causadas por virus mÃ¡s comunes en el Chile para Secado en Aguascalientes.	\N	2015	tecnica	pdf	enfComunesChileAgs.png	enfComunesChileAgs.pdf	\N	\N	413	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
303	El banco de germoplasma de chile en el Campo Experimental Zacatecas.	\N	2016	tecnica	pdf	Bgermoplasmachile.png	Bgermoplasmachile.pdf	\N	\N	352	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
304	Cambios en el metabolismo de los fenilpropanoides en plantas de chile tipo mirasol infectadas por fitoplasma.	\N	2016	tecnica	pdf	Fenilpropanoides.png	Fenilpropanoides.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
305	Candidatus Liberibacter Solanacearum: un nuevo fitopatogeno en el cultivo de chile en el norte centro de MÃ©xico.	\N	2016	tecnica	pdf	LiberibacterSolanacearum.png	LiberibacterSolanacearum.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
306	Presencia de chicharritas (hemiptera:cicadellidae) durante el invierno en Zacatecas y Aguascalientes.	\N	2016	tecnica	pdf	Presenciachicharritas.png	Presenciachicharritas.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
307	La vida en el suelo es la base de la fertilidad de los suelos agrÃ­colas	\N	2016	tecnica	pdf	vidaSueloAgri.png	vidaSueloAgri.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
308	ReducciÃ³n de la irrigaciÃ³n: una alternativa para mejorar la productividad del agua de riego en la producciÃ³n de chile cv. Mirasol	\N	2016	tecnica	pdf	redIrrMirasol.png	redIrrMirasol.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
309	Comportamiento morfolÃ³gico y productivo de Colectas Base de GramÃ­neas nativas e introducidas en el altiplano de Zacatecas.	\N	2016	tecnica	pdf	ColectasGramineas16.png	ColectasGramineas16.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
310	TecnologÃ­a para la producciÃ³n de Cultivos, en el Ã¡rea de influencia del Campo Experimental Zacatecas.	\N	2016	tecnica	pdf	guiaTecnicaZac.png	guiaTecnicaZac.pdf	\N	\N	337	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
311	Patrimonio FitogenÃ©tico: Banco De Germoplasma de semillas ortodoxas del Campo Experimental Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 81.png	Folleto Tecnico 81.pdf	\N	\N	336	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
312	Comparacion Morfologica de poblaciones de Circulifer Tenellus muestreadas En Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 83.png	Folleto Tecnico 83.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
313	Curtovirus Comos agentes FitopatÃ³genos en el Norte Centro De MÃ©xico.	\N	2017	tecnica	pdf	Folleto Tecnico 84.png	Folleto Tecnico 84.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
314	La Mancha PÃºrpura de la Zanahoria en Zacatecas; Una Nueva Enfermedad.	\N	2017	tecnica	pdf	Folleto Tecnico 85.png	Folleto Tecnico 85.pdf	\N	\N	335	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
315	El Moho Blanco de la Lechuga causado por Sclerotinia en Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 86.png	Folleto Tecnico 86.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
316	DiseÃ±o de transmisiÃ³n de Fitoplasmas a Catharanthus Roseus como reservorio natural.	\N	2017	tecnica	pdf	Folleto Tecnico 87.png	Folleto Tecnico 87.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
317	IdentificaciÃ³n de enfermedades causadas por Bacterias y Nematodos en cultivos de Aguascalientes, Durango Y Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 89.png	Folleto Tecnico 89.pdf	\N	\N	464	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
318	IdentificaciÃ³n de enfermedades causadas por Hongos en cultivos de Aguascalientes, Durango Y Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 90.png	Folleto Tecnico 90.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
319	IdentificaciÃ³n de Enfermedades causadas por virus en cultivos de Aguascalientes, Durango Y Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 91.png	Folleto Tecnico 91.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
320	Cambio climÃ¡tico y sus efectos en el potencial productivo de chile en el norte centro de MÃ©xico.	\N	2017	tecnica	pdf	Folleto Tecnico 88.png	Folleto Tecnico 88.pdf	\N	\N	336	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
321	Variedades, portainjertos y prÃ¡cticas agronÃ³micas para la producciÃ³n de uva de mesa en Zacatecas.	\N	2017	tecnica	pdf	Folleto Tecnico 82.png	Folleto Tecnico 82.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
322	P.E.: Accesiones de Opuntia Spp. del banco de germoplasma del Cezac.	\N	2018	tecnica	pdf	PE23.png	PE23OpuntiaAccesiones.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
323	Uso de descriptores para la caracterizaciÃ³n fenolÃ³gica del banco de germoplasma de Opuntia del Cezac.	\N	2018	tecnica	pdf	FT99.png	FT99FolletoUsodescriptores.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
324	Sanidad de la semilla de Ajo en Aguascalientes y Zacatecas, MÃ©xico Centro.	\N	2018	tecnica	pdf	FT98.png	FT98FolletoAjo.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
325	Hongos y Nematodos asociados con la pudriciÃ³n de la corona de la Alfalfa en el Norte Centro de MÃ©xico.	\N	2018	tecnica	pdf	FT97.png	FT97FolletoAlfalfa.pdf	\N	\N	335	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
326	IdentificaciÃ³n molecular de fitoplasmas en el cultivo de BrÃ³coli (Brassica Oleracea) en Aguascalientes, MÃ©xico.	\N	2018	tecnica	pdf	FT95.png	FT95FolletoBrocoli.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
327	IdentificaciÃ³n molecular de la presencia de Fitoplasmas en el cultivo de Tomatillo (Physalis Ixocarpa brot. Ex Hornem) en Zacatecas.	\N	2018	tecnica	pdf	FT93.png	FT93FolletoTomatillo.pdf	\N	\N	349	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
328	GÃ©neros de Chicharritas (Hemiptera:Cicadellidae) presentes en el cultivo de Chile en el Norte Centro de MÃ©xico.	\N	2018	tecnica	pdf	FT92.png	FT92FolletoGenerosdeChicharritas.pdf	\N	\N	338	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
329	DiagnÃ³stico e identificaciÃ³n de begomovirus en el cultivo de chile en los estados de Zacatecas y Durango	\N	2019	tecnica	pdf	101 Folleto Begomovirus Zac-Dgo.png	101 Folleto Begomovirus Zac-Dgo.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
330	EvaluaciÃ³n de la interacciÃ³n directa de cepas de Fusarium equiseti y Fusarium graminearum en plantas de Arabidopsis thaliana	\N	2019	tecnica	pdf	104 Folleto Evaluacion de la interaccion 5 cepas.png	104 Folleto Evaluacion de la interaccion 5 cepas.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
331	EvaluaciÃ³n de la capacidad benÃ©fica e identificaciÃ³n molecular de cepas de Fusarium spp aisladas de plantas de maÃ­z	\N	2019	tecnica	pdf	105 Folleto Identificacion Molecular Fusarim.png	105 Folleto Identificacion Molecular Fusarim.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
332	Calidad fÃ­sica y nutraceutica de chile secado por diferentes mÃ©todos.	\N	2019	tecnica	pdf	secadoChile.png	secadoChile.pdf	\N	\N	337	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
333	PatÃ³genos asociados con la virosis del chile en el estado de Durango	\N	2020	tecnica	pdf	Patog virosis.png	Patog virosis.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
334	CaracterizaciÃ³n de genotipos de durazno para Zacatecas y regiones agroecolÃ³gicas similares	\N	2021	tecnica	pdf	Carac durazno.png	Carac durazno.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
335	SÃ­ntomas provocados por el candidatus phytoplasma trifolii en diferentes hospederos en Zacatecas, MÃ©xico	\N	2019	tecnica	pdf	03 FT 102 Hospederos digital.png	03 FT 102 Hospederos digital.pdf	\N	\N	357	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
336	GÃ©neros de nematodos asociados al cultivo de chile para secado en el altiplano de Zacatecas	\N	2019	tecnica	pdf	04 FT 103 Nemátodos digital.png	04 FT 103 Nemátodos digital.pdf	\N	\N	424	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
337	Gusano cogollero (Spodoptera frugiperda) JE Smith en Zacatecas	\N	2019	tecnica	pdf	07 FT 106 Gusano Cogollero.png	07 FT 106 Gusano Cogollero.pdf	\N	\N	360	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
338	PÃ©rdidas causadas por la Virosis en el cultivo de chile del Ã¡rea de poanas, Durango	\N	2020	tecnica	pdf	poanas.png	20312PUB02.pdf	\N	\N	332	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
339	Arreglos topolÃ³gicos y densidades de siembra en el cultivo de frijol de riego en Zacatecas	\N	2021	tecnica	pdf	20312PUB04 Folleto JA.png	20312PUB04 Folleto JA.pdf	\N	\N	391	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
340	Manejo de la pudriciÃ³n de la raÃ­z del frijol en Zacatecas	\N	2021	tecnica	pdf	20312PUB01 Folleto JA.png	20312PUB01 Folleto JA.pdf	\N	\N	336	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
341	Combate de la pudriciÃ³n blanca del ajo y la cebolla en Zacatecas	\N	2021	tecnica	pdf	20312PUB02 Folleto MR.png	20312PUB02 Folleto MR.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
342	Trampa alimenticia para el manejo agroecolÃ³gico de insectos plaga en cultivos bÃ¡sicos y hortalizas	\N	2021	tecnica	pdf	20312PUB03 Folleto JM.png	20312PUB03 Folleto JM.pdf	\N	\N	561	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
343	Virus presentes en ajo, cebolla y chile en el norte centro de MÃ©xico	\N	2021	tecnica	pdf	Libro Técnico Virus.png	Libro Técnico Virus.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
344	Desplegable - Variedades de durazno: estudio sensorial y mercados nacionales	\N	2022	tecnica	pdf	desdurazno.png	desdurazno.pdf	\N	\N	337	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
345	TÃ©cnicas para estimar y monitorear la demanda de agua en los cultivos	\N	2018	tecnica	pdf	Libro Técnico Num 17 2018.png	Libro Técnico Num 17 2018.pdf	\N	\N	339	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
346	Carga animal del pastizal mediano abierto en Zacatecas (Invierno 2007-2008)	\N	2008	tecnica	pdf	cargaAnimal2008.png	cargaAnimal2008.pdf	\N	\N	361	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
347	Aprovechamiento sostenible de pastizales a travÃ©s del ajuste de carga animal en zonas secas	\N	2018	tecnica	pdf	aproCargaAni.png	aproCargaAni.pdf	\N	\N	376	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
348	TallarÃ­n enriquecido con harina de frijol: aceptaciÃ³n en el mercado y costo de producciÃ³n	\N	2022	tecnica	pdf	42 Folleto Productores Tallarín_seg.png	42 Folleto Productores Tallarín_seg.pdf	\N	\N	330	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
349	Combate de enfermedades provocadas por virus en hortalizas	\N	2022	tecnica	pdf	43 Folleto para productores Virus_seg.png	43 Folleto para productores Virus_seg.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
350	Sistemas de siembra recomendados para frijol bajo temporal en Zacatecas	\N	2022	tecnica	pdf	44 Folleto para productores Sistemas_seg.png	44 Folleto para productores Sistemas_seg.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
351	Funcionalidad de las cÃ¡scaras de la tuna Roja Lisa: Parte I (in vitro)	\N	2022	tecnica	pdf	111 Folleto Técnico Funcionalidad_seg.png	111 Folleto Técnico Funcionalidad_seg.pdf	\N	\N	366	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
352	DiseÃ±o, aplicaciÃ³n y anÃ¡lisis de tipologÃ­a de productores agropecuarios	\N	2022	tecnica	pdf	113 Folleto Técnico Diseño_seg.png	113 Folleto Técnico Diseño_seg.pdf	\N	\N	294	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
353	Cambios en la concentraciÃ³n de metabolitos en plantas de chile por efecto de la luz ultravioleta	\N	2022	tecnica	pdf	114 Folleto Técnico Metabolitos_seg.png	114 Folleto Técnico Metabolitos_seg.pdf	\N	\N	333	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
354	IdentificaciÃ³n molecular del agente causal asociado a la sintomatologÃ­a del engrosamiento del cladodio (Opuntia spp.) en Zacatecas	\N	2022	tecnica	pdf	115 Folleto Técnico Identificación_seg.png	115 Folleto Técnico Identificación_seg.pdf	\N	\N	329	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
355	El riego y almacenamiento modifican el contenido de pigmentos y fenoles de la tuna Roja Lisa	\N	2022	tecnica	pdf	112 Folleto Técnico Tuna Roja Lisa_seg.png	112 Folleto Técnico Tuna Roja Lisa_seg.pdf	\N	\N	327	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
356	PlaneaciÃ³n del ciclo AgrÃ­cola en unidades de ProducciÃ³n de riego en Zacatecas	\N	2018	tecnica	pdf	05-FT 96 Planeacion 2018.png	05-FT 96 Planeacion 2018.pdf	\N	\N	331	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
357	EstadÃ­sticas climatolÃ³gicas horarias del Estado de Zacatecas (PerÃ­odo 2002-2022)	\N	2023	tecnica	pdf	estClima_Zac.png	estClima_Zac.pdf	\N	\N	334	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
358	TecnologÃ­a para la producciÃ³n de maÃ­z en condiciones de temporal en Zacatecas	\N	2023	tecnica	pdf	FP46 RSan.png	FP46 RSan.pdf	\N	\N	371	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
359	SuplementaciÃ³n alimenticia en colonias de abejas melÃ­feras del Ã¡rido y semiÃ¡rido de MÃ©xico	\N	2023	tecnica	pdf	FP47 RGut.png	FP47 RGut.pdf	\N	\N	350	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
360	Establecimiento de zacate buffel Pennisetum ciliaris L bajo condiciones de temporal, en el semiÃ¡rido de Coahuila, MÃ©xico	\N	2023	tecnica	pdf	FT118 RGut.png	FT118 RGut.pdf	\N	\N	345	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
361	Efecto antidiabÃ©tico de tallarines con harina extruida de cotiledones de frijol en un modelo in vivo	\N	2023	tecnica	pdf	FT120 RCruz.png	FT120 RCruz.pdf	\N	\N	343	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
362	Funcionalidad de las cÃ¡scaras de la tuna Roja Lisa Parte II, in vivo	\N	2023	tecnica	pdf	FT121 MHer.png	FT121 MHer.pdf	\N	\N	348	\N	t	2026-03-20 16:40:44	2026-03-20 16:40:44
363	Prueba	\N	2026	cientifica	pdf	\N	uploads/archivos/ooycwd0KhONcQRkHBiOBfGnGjIsac8bGyaAQHP8g.pdf	\N	lkl	0	\N	t	2026-03-20 17:02:13	2026-03-20 17:02:13
364	Teodio	\N	2026	ilustracion	video	\N	uploads/archivos/qZ9q03pkVgHZaBkARSc7aLypWATvCj2TZdu2G9cM.webm	\N	Teodio	0	\N	t	2026-03-26 17:24:19	2026-03-26 17:24:19
365	MIra we	\N	2026	ilustracion	audio	\N	uploads/archivos/uoB7ReRk7OqsZpMuTV3L43Ymwaz4fYExjvpWOggI.mp3	\N	un video we	0	\N	t	2026-03-26 18:03:15	2026-03-26 18:03:15
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
PlwGWhTLVMUrOgk32vsvv9K48vnXmCGuSemy0bXV	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoibFkyYTBzazlMVDRnWUw1YmtzSTdPMWNlTmtSYmh2aHAyZlNXcFNJQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9pbWFnZW5lcy9pY29hdWRpby5wbmciO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1774556163
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: inifap_user
--

COPY public.users (id, name, email, email_verified_at, password, is_contributor, remember_token, created_at, updated_at) FROM stdin;
1	Usuario Prueba	test@example.com	\N	$2y$12$lTHDaJPvHvIF/VNlsrOF7.q5gGrmxBwZbViOANjqouPC9H/rbjYku	f	\N	2026-03-20 16:40:44	2026-03-20 16:40:44
\.


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inifap_user
--

SELECT pg_catalog.setval('public.files_id_seq', 4, true);


--
-- Name: media_archivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inifap_user
--

SELECT pg_catalog.setval('public.media_archivos_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inifap_user
--

SELECT pg_catalog.setval('public.migrations_id_seq', 5, true);


--
-- Name: publicaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inifap_user
--

SELECT pg_catalog.setval('public.publicaciones_id_seq', 365, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inifap_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: media_archivos media_archivos_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.media_archivos
    ADD CONSTRAINT media_archivos_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: publicaciones publicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT publicaciones_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: inifap_user
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: inifap_user
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: media_archivos media_archivos_publicacion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.media_archivos
    ADD CONSTRAINT media_archivos_publicacion_id_foreign FOREIGN KEY (publicacion_id) REFERENCES public.publicaciones(id) ON DELETE CASCADE;


--
-- Name: publicaciones publicaciones_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: inifap_user
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT publicaciones_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict EVAq03h6NIagMdfETPJEUJLteV81Nbt1JYdW4okJku7lB8yqdiUrbDKYfmxe86K

