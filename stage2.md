
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

CPU cores
    1 vs 2
Disk Configuration (last resort)
    HDD vs SDD
Number of nodes 
    3 vs 5
Snapshot Count
    5000 vs 10000
BackendBatchLimit (maximum operations before commit the backend transaction)
    5000 vs 10000
Go Garbage Collection Percentage
    100% vs 10%

Machines:
n1-standard-1  -> 1 core HDD

A - CPU Cores (1,2)
B - Disk Configuration (HDD,SDD)
C - Number of nodes (3,5)
D - Snapshot Count (5000,10000)
E - BackendBatchLimit (5000, 10000)
F - Go Garbage Collection (10,100)

Experiment  A   B   C   D   E   F 
1           -1  -1  -1  1   1   1 
2           1   -1  -1  -1  -1  1 
3           -1  1   -1  -1  1   -1 
4           1   1   -1  1   -1  -1 
5           -1  -1  1   1   -1  -1 
6           1   -1  1   -1  1   -1 
7           1   1   1   -1  -1  1 
8           1   1   1   1   1   1 






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


# Experiments

6 Factors
2 Levels, per factor
R replications

- Vary on factor at a time (Simple Design)

Varying a single factor while keeping the remaining fixed may lead to 
wrong conclusions if factors interact. Not efficient and should not be
used.

- Full Factorial Design

Test all combinations. Too expensive.

- Fractional Factorial Design

Only measure some combinations, must design carefully to best capture any
possible interactions

- 2^k Factorial Design

Determine the effect of k factors with 2 levels each.
Only valid if effect is unidirectional -> effects that only increase as the
level of a factor increases

- 2² Factorial Design

|    |   6  |  64  |
|----|------|------|
| NO |  820 |  217 |
| YES|  776 |  197 |

Regression Model:

x_a = -1 (8) or x_a = 1 (64)
x_b = -1 (NO) or x_b = 1 (YES)

q_0 = baseline
q_a,q_b = performance due to a/b
q_ab = performance due to interaction of a and b

y = q0 + qAxA + qBxB + qABxAxB

To find each q value solve:

820 = q0 - qA - qB + qAB
217 = q0 + qA - qB - qAB
776 = q0 - qA + qB - qAB
197 = q0 + qA + qB + qAB

q0 = 1/4(820 + 217 + 776 + 197) = 502.5
qA = 1/4(-820 + 217 - 776 + 197) = -295.5
qB = 1/4(-820 - 217 + 776 + 197) = -16
qAB = 1/4(820 - 217 - 776 + 197) = 6

y = 502.5 - 295.5xA - 16xB + 6xAxB

Now build a sign table that has all combinations of -1 and 1
for A,B,AB

|   | A  | B  | AB  |  y   |
|---|----|-----|----|------|
|   | -1 | -1  |  1 | 820  |
|   |  1 | -1  | -1 | 217  |
|   | -1 |  1  | -1 | 776  |
|   |  1 |  1  |  1 | 197  |

(skipped a table that i dont understad)

To quantify the impact of each factor and their interaction:

SST = SSA + SSB + SSAB
SST = 2^2qA^2 + 2^2qB^2 + 2^2qAB^2
SST = 350 449
SSA = 349 281
SSB = 1 024
SSAB = 144

Effect of A = SSA/SST = 99.67%
Effect of B = SSB/SST = 0.29%
Effect of AB = SSAB/SST = 0.04%

Therefore increase the number of cores and disable DLM

- 2²_r Factorial Design

Same as the previous but with R replications to consider experimental error
(ver formula de SSE nos slides)

SST = SSA + SSB + SSAB + SSE
SST = 2^2 * 4 * qA^2 + 2^2 * 4 * qB^2 + 2^2 * 4 * qAB^2 + SSE
SST = 1 377 009
SSA = 1 386 900
SSB = 5041
SSAB = 462.25
SSE = 2606.5

Can also compute the mean square of errors

- 2^(k-p) Factorial Design

We can do experiments where several factor levels are combined (confounded)
into one

Ideally confound significant effects with insignificant ones
E.g.:  Make D equal to AB, qAB and qD will be confounded