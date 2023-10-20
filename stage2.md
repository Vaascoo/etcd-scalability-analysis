
# Assignment

Design and describe the evaluation process of the system under test, namely:

    •Identify and describe the system and workload parameters.
    > Done in stage 1 maybe go in greater details in workload parameters

    •Design an experiment that allows to efficiently assess the effect of the different factors and levels. The experiment should consider at least 6 factors at two levels each.
    > 
        Factors: parameters that are varied in the performance study
            E.g.: in a web client factors could be page size, number of links, fonts required, embedded graphics, sound, etc. In a network factors could be bandwidth, latency, transport protocol. 
        Levels: values taken by each factors

    •Select, and justify, the metrics, factors and levels used in the experimental design.
    > Example of metrics could be response time, connection setup time, response latency, achieved bandwidth, transfer rate, etc

    •Discuss and justify the experimental design (sign table) and the obtained results.

    > not sure yet how sign tables work but slides talk about it (04-benchmarking)

Select one of the factors with the most effect and analyse the scalability properties
of the system. Discuss the different portions that limit the scalability of the system
under test according to the USL.

    > USL provides a model of system performance under load, predicts behavior beyond observed load (slides 05-capacity-planning)


# Factors

Number of nodes 
    3 vs 5
Snapshot Count
    5000 vs 10000
CPU cores (???)
    1 vs 2
BackendBatchLimit

Disk Configuration (last resort)
    HDD vs SDD



------
Number of clients
Number of connections
Heartbeat interval (only relevant in crash fault model)
Election timeout   (same ^)
Snapshot

Key size 
    8 vs 256
Ratio 
    50% vs 90%
Consistency
    Serializable vs linearizable



Identify main factos (e.g. 3) and the other are 
confounded
