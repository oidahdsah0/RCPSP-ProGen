# ProGen in Matlab

Project scheduling problem Instance generator for RCPSP/MRCPSP, matlab version, open source.

In view of the fact that the old ProGen program on the PSPLib official website has been around for some years, and there is almost no source code available for modification, I decided to use Matlab to implement the code in the paper by Kolisch, R., Sprecher, A. and Drexl, A.

However, I have to say that the current code is still in the prototype stage, and there are some hidden BUGs that are relatively deep, and we will follow up and update (probably, haha).

Of course, if you have any academic questions about the RCPSP field, please feel free to contact us.

E-mail: rareleo@qq.com

Finally, grateful to eborghi10's work, what inspired us a lot : https://github.com/eborghi10/RCPSP

## Usage

1. Open main.m;
2. Set J_proj to the number of real jobs (Except dummy jobs);
3. Set m_list as the mode of you project, array is allowed.
4. Set C_list as the complexity of your project, array is allowed.
5. RRF_list for RRF, RRS_list for RRS, NRF, NRS, and so on ...
6. Last but not least, set the number of examples to generate.
7. Wait, several cups of coffee ...
8. Find what you want in dataSets folder.

## Our work

The following are some of our studies, welcome to read or cite：

1. Liu, Y., Li, R. and Liu, H., 2020. Heuristic optimization for robust resource-constrained flexible project scheduling problem. IEEE Access, 8, pp.142269-142281.

2. Liu, H., Qu, S., Li, R. and Razaa, H., 2021. Bi-objective robust project scheduling with resource constraints and flexible activity execution lists. Computers & Industrial Engineering, 156, p.107288.

3. Liu, H., Fang, Z. and Li, R., 2022. Credibility-based chance-constrained multimode resource-constrained project scheduling problem under fuzzy uncertainty. Computers & Industrial Engineering, 171, p.108402.

## Reference

Kolisch, R., Sprecher, A. and Drexl, A., 1995. Characterization and generation of a general class of resource-constrained project scheduling problems. Management science, 41(10), pp.1693-1703.
