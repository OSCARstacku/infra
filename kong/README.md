                    Frontend (Angular)

                           │
                     HTTP / HTTPS
                           │
                    +----------------+
                    |      Kong      |
                    +----------------+
                     │      │      │
                 gRPC│      │gRPC  │gRPC
                     ▼      ▼      ▼

        sdata-ms-admin   sdata-ms-user   sdata-ms-base
               │              │               │
               ├──────────────┼───────────────┤
                              │
          ---------------------------------------------
          │                  │                  │
       MongoDB          Dragonfly         Apache Pulsar