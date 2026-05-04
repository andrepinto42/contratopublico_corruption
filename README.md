> This repository is a fork of https://github.com/chicoferreira/contratopublico

# Contrato Público (Fork)

This is a fork of the original Contrato Público project.

While the original focuses on providing a fast search interface for Portuguese public contracts, this fork focuses on data extraction and analysis.

## Purpose of this fork

- Scraping contracts by specific dates
- Filtering and analyzing data by concelho (municipality)
- Detecting anomalies and potential corruption patterns in public procurement
- Generating structured summaries of findings
- Creating Instagram posts from detected insights

## How to use it

My most used commands:

* Start docker compose

`docker compose -f docker/compose.yml up -d`


* Run the app

`cargo run --release --manifest-path backend/Cargo.toml --bin cli -- scrape --start-date 2026-05-04 --end-date 2026-05-05`

* Resync Postgres and Mileisearch

`cargo run --release --manifest-path backend/Cargo.toml --bin cli -- rebuild-search-index`

* Check the database

`docker exec -it contratopublico-postgres-1 psql -U contratopublico -d contratopublico -c "Select count(*) from contracts"`


## Notes

This project is experimental and focused on data analysis and pattern detection, not official reporting or legal conclusions.

## Original project

The original project can be found here:
https://github.com/chicoferreira/contratopublico