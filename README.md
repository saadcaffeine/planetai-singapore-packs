# PlanetAI Singapore packs

Packs for a [PlanetAI node](https://github.com/fabcity/planetai-node) in Singapore. They are **wild** packs in the
node's own terms ([docs/decisions/2026-10-01-packs.md](https://github.com/fabcity/planetai-node/blob/main/docs/decisions/2026-10-01-packs.md)):
they live outside the release and a node adds the ones it wants.

| pack | what it does | needs |
|---|---|---|
| `singapore-nea` | NEA and PUB open data from data.gov.sg: PSI and PM2.5, temperature, humidity, rain, wind, UV, WBGT, flood alerts, dengue clusters, forecasts | optional `NEA_API_KEY` |
| `singapore-beach` | NEA weekly beach water-quality bands | `BEACH_AREAS` |
| `fire-smoke` | NASA FIRMS fires within 500 km, by compass sector, and the rules that ask whether the wind is blowing from them | `FIRMS_MAP_KEY` |
| `tuya-indoor` | Room temperature and humidity from Tuya / Smart Life sensors through the Tuya Cloud API | `TUYA_*` |

All four are code packs: they run only with `PACKS_ALLOW_CODE=1`. Read each `adapter.py` first.

## Install

On the node, in its folder, with curl and tar (no git needed). One pack at a time:

```
curl -fsSL https://codeload.github.com/saadcaffeine/planetai-singapore-packs/tar.gz/main | tar xz -C packs --strip-components=1 planetai-singapore-packs-main/singapore-nea
planetai packs install      # its env: lines into .env
planetai restart
```

Change `singapore-nea` for another pack, or leave the path off to take all four (the repository's `tests/`, `README.md`
and `LICENSE` land in `packs/` too: delete them). To pin what you read, replace `main` with a full commit id.

## What these packs lean on in the node

- `tuya-indoor` marks a room `secondary` (`meta.role`). The node must know that role (the issues engine and
  `packs/heat/rules.yml` skip secondary rooms). It is in the node's generic fixes, not in a release yet.
- The Singapore wall rows, the Air region row ("NEA, then CAMS"), the PSI/wind/WBGT/beach readouts and the Singapore
  wall layers are not in these packs: they cannot travel as a pack yet. They are one node's fork,
  [saadcaffeine/planetai-node-sg](https://github.com/saadcaffeine/planetai-node-sg), until the node has per-node
  overrides and pack readouts.

## Tests

Offline, no network, from the node's folder:

```
sh path/to/planetai-singapore-packs/tests/run.sh
```

`test_singapore_wind_rule.py` needs `pip install duckdb` and skips without it. The payloads in the NEA and beach tests
are written by hand from the documented shapes; replacing them with captures is a to-do.

## Licence and data

Apache-2.0, as the node. The data belongs to its publishers: NEA and PUB (Singapore Open Data Licence v1.0, via
data.gov.sg), NASA FIRMS / LANCE, and the Tuya Cloud API for your own devices. Each pack's `pack.yaml` carries the
attribution it must show.
