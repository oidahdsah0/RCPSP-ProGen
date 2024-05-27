# ProGen in Matlab

**Project Scheduling Problem Instance Generator for RCPSP/MRCPSP, Matlab Version, Open Source**

Considering that the old ProGen program on the PSPLib official website has been around for several years and there is almost no source code available for modification, we decided to implement the code from the paper by Kolisch, R., Sprecher, A., and Drexl, A.[1] using Matlab.

Currently, the code is still in the prototype stage. Several modifications are necessary to tailor it to your specific needs. We will provide updates and improvements as needed.

If you have any academic questions about the RCPSP field, please feel free to contact us.

For queries on implementation or the RCPSP field, contact: rareleo@qq.com (Li, R.)

We would also like to acknowledge the work of eborghi10, which greatly inspired this project: [eborghi10's RCPSP](https://github.com/eborghi10/RCPSP)

# Usage:
1. Open `main.m`
2. Set `J_proj` to the number of real jobs (excluding dummy jobs)
3. Set `m_list` as the mode of your project (array is allowed)
4. Set `C_list` as the complexity of your project (array is allowed)
5. Define `RRF_list` for RRF, `RRS_list` for RRS, NRF, NRS, etc.
6. Set the number of examples to generate (`expNum`)
7. Wait a few minutes...
8. Find your results in the `dataSets` folder

# Additional Work:
Here are some of our studies in the RCPSP/MRCPSP field. Feel free to read or cite:

- Liu, Y., Li, R. and Liu, H., 2020. Heuristic optimization for robust resource-constrained flexible project scheduling problem. *IEEE Access*, 8, pp.142269-142281.
- Liu, H., Qu, S., Li, R. and Razaa, H., 2021. Bi-objective robust project scheduling with resource constraints and flexible activity execution lists. *Computers & Industrial Engineering*, 156, p.107288.
- Liu, H., Fang, Z. and Li, R., 2022. Credibility-based chance-constrained multimode resource-constrained project scheduling problem under fuzzy uncertainty. *Computers & Industrial Engineering*, 171, p.108402.

# Reference:
[1] Kolisch, R., Sprecher, A., and Drexl, A., 1995. Characterization and generation of a general class of resource-constrained project scheduling problems. *Management Science*, 41(10), pp.1693-1703.
