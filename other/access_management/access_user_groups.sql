-- Create WP groups and grant them access to the respective dataset groups.

CREATE ROLE wp1 WITH NOLOGIN;
GRANT synpuf_1k_group TO wp1;
GRANT erspc_synth_group TO wp1;

CREATE ROLE wp3 WITH NOLOGIN;
GRANT synpuf_1k_group TO wp3;
GRANT erspc_synth_group TO wp3;

CREATE ROLE wp4 WITH NOLOGIN;
GRANT synpuf_1k_group TO wp4;
GRANT erspc_synth_group TO wp4;

CREATE ROLE wp5 WITH NOLOGIN;
GRANT synpuf_1k_group TO wp5;
GRANT erspc_synth_group TO wp5;
GRANT erspc_group TO wp5;
GRANT active_biotech_group TO wp5;
