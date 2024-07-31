# acicn

Series of Container Images with Advanced Features

## Debian

- `ghcr.io/yankeguo/acicn/debian:12-240731-1022`
  - `minit:1.14.0-rc2` as entrypoint
  - `tini`

## JDK

- Base (Not for direct use)
  - `ghcr.io/yankeguo/acicn/jdk:base-240729-2245`
    - from `acicn/debian:12-240729-2154`
    - `Adoptium APT Repository`
    - `arthas:3.7.2`
    - `jmx_prometheus_javaagent:0.16.1`
    - `skywalking-agent:custom-20231214`
- JDK 21
  - `ghcr.io/yankeguo/acicn/jdk:21-240729-2303`
    - from `acicn/jdk:base-240729-2245`

## Credits

GUO YANKE, MIT License
