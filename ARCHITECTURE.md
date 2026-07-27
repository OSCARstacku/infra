# ###############################################################
#                          ARCHITECTURE
# ###############################################################

                            Frontend

                               │ HTTP/HTTPS - JSON REST
                               ▼
                          Kong Gateway
                               │ gRPC (HTTP/2)
            ┌──────────────────┼──────────────────┐
            ▼                  ▼                  ▼
        ms-admin          ms-users          ms-orders
            │                  │                  │
            ├──────────────────┬──────────────────┐
            ▼                  ▼                  ▼
        MongoDB           DragonflyDB        Apache Pulsar
                                                  │
                                              websocket-ms
                                                  │
                                             WebSocket/SSE
                                                  │
                                               Angular

# ###############################################################
