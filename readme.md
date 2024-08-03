# nvr.ai infra

> Quickstart: `make setup infra/up services/up`

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [helm](https://helm.sh/docs/intro/install/)
- [kustomize](https://kustomize.io/docs/installation/)

## Services

| Service                   | Description                      | Address                   |
| ------------------------- | -------------------------------- | ------------------------- |
| `riser-infra-timescaledb` | TimescaleDB PostgreSQL database. | `10.67.0.10:5432`         |
| `riser-infra-rabbitmq`    | RabbitMQ message broker.         | <http://10.67.0.11:15672> |
| `riser-app-spa`           | Frontend application (SPA).      | <http://10.67.0.100:8888> |
| `riser-service-broker`    | WebSockets service broker.       | `10.67.0.101:10000`       |

## Managing

Commands:

| Command                                  | Description                       |
| ---------------------------------------- | --------------------------------- |
| `make services/up`                       | Start all services.               |
| `make services/down`                     | Stop all services.                |
| `make services/logs`                     | View logs for all services.       |
| `make service/up SERVICE=<service>`      | Start a single service.           |
| `make service/down SERVICE=<service>`    | Stop a single service.            |
| `make service/restart SERVICE=<service>` | Restart a single service.         |
| `make service/logs SERVICE=<service>`    | View logs for a single service.   |
| `make service/exec SERVICE=<service>`    | Get a shell for a single service. |
| `make service/build SERVICE=<service>`   | Build a single service.           |
| `make service/build/all`                 | Build all services.               |

### Building

Before running the services they must be built first.

### Building all services

Build all services in parallel:

```bash
make build/all
```

### Building a single service

Build a single, one off service:

> Don't forget to `make service/restart SERVICE=<service>` after building!

```bash
make build/service SERVICE=riser-service-broker
```

or

```bash
make build/service SERVICE=riser-service-controller
```

### Running

Starting, stopping, and restarting services.

#### Prerequisites

To create the docker network run:

```bash
make setup
```

#### Start infra services

To start TimescaleDB and RabbitMQ run:

```bash
make infra/up
```

To start the services run:

```bash
make services/up
```

or to start individual services run:

```bash
make service/up SERVICE=riser-service-broker
```

or

```bash
make service/up SERVICE=riser-service-controller
```
