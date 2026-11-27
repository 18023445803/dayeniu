# 一生一芯（YSYX）E、F 阶段讲义知识点总结

> 整理自官网课程主页 <https://ysyx.oscc.cc/docs/> 的 v26.07 版学习讲义（F1–F7、E1–E9）。
> 讲义主线：**F 阶段打数字电路基础 → E 阶段用 HDL 做出可运行程序的迷你 RISC-V 处理器 → 通过入学答辩进入正式学习**。
> 贯穿全课程的核心方法论：**STFW / RTFM / RTFSC**（独立解决问题）、**状态机视角**、**"实例化 + 连线"的电路思维**。

---

## 目录

- [〇、全局脉络](#〇全局脉络)
- [F 阶段：预学习（数字电路基础）](#f-阶段预学习数字电路基础)
  - [F1 如何科学地提问](#f1-如何科学地提问)
  - [F2 Logisim 安装和使用](#f2-logisim-安装和使用)
  - [F3 数字逻辑电路基础](#f3-数字逻辑电路基础)
  - [F4 计算机系统的状态机模型](#f4-计算机系统的状态机模型)
  - [F5 支持数列求和的简单处理器](#f5-支持数列求和的简单处理器)
  - [F6 简易输入输出](#f6-简易输入输出)
  - [F7 F 阶段流片准备](#f7-f-阶段流片准备建设中)
- [E 阶段：预学习（HDL 与处理器）](#e-阶段预学习hdl-与处理器)
  - [E1 硬件描述语言](#e1-硬件描述语言)
  - [E2 C 语言程序设计](#e2-c-语言程序设计)
  - [E3 Linux 系统安装和基本使用](#e3-linux-系统安装和基本使用)
  - [E4 处理器的仿真和验证](#e4-处理器的仿真和验证)
  - [E5 功能完备的迷你 RISC-V 处理器](#e5-功能完备的迷你-risc-v-处理器)
  - [E6 简易运行时环境](#e6-简易运行时环境)
  - [E7 简易总线和 SoC](#e7-简易总线和-soc)
  - [E8 后端物理设计和流片准备](#e8-后端物理设计和流片准备)
  - [E9 提交入学答辩申请](#e9-提交入学答辩申请)
- [附录：核心概念速查表](#附录核心概念速查表)

---

## 〇、全局脉络

### E/F 阶段在课程中的定位

"一生一芯"采用阶梯式 **C-B-A-S** 分级体系，而在正式阶段之前还有一个**预学习阶段（F + E）**：

```
预学习：F 阶段（数字电路入门） → E 阶段（HDL + 迷你处理器 + 后端） → 入学答辩
正式学习：D 阶段 → C 阶段 → B 阶段（流片考核） → A / S 阶段（高阶）
```

- **四个基础模块**：F3 数字电路、E1 C 语言、E2 Verilog、E3 Linux。
- **五大核心实践**：① Logisim 上实现简单处理器（sCPU / minirvCPU）；② 指令集模拟器（sEMU / minirvEMU）；③ NVBoard 数字电路实验；④ 用 Verilog 实现 sCPU；⑤ PA1（NEMU 调试器）。
- **符号约定**：`C`=C 语言 / 程序 / 模拟器 / 系统软件，`R`=RISC-V 指令集，`P`=处理器设计，`T`=工具。

### 三条贯穿始终的思想主线

1. **状态机视角**：C 程序、ISA、数字电路三者都是状态机。
   - 编译 = 把 C 状态机翻译成 ISA 状态机；CPU 设计 = 用数字电路状态机实现 ISA 状态机。
   - 在 CPU 上执行程序 = 用程序编译出的指令序列控制 CPU 电路进行状态转移。
2. **"实例化 + 连线"的电路思维**：数字电路设计本质上只做两件事，用 HDL 只是换了方式，头脑中要能从代码想象出电路结构。
3. **独立解决问题**：STFW（搜网络）、RTFM（读手册）、RTFSC（读源码）；"机器永远是对的"；帮助别人时"授人以鱼不如授人以渔"；AI 时代更要独立思考。

### 一条教学主线：从 0 到"在自己的芯片上跑程序"

```
晶体管 → 门电路 → 组合/时序逻辑电路 → 状态机模型 → sISA/sCPU（4 条指令）
→ Verilog 实现 → 仿真/验证(DiffTest) → minirv（8 条 RISC-V 指令）
→ 运行时环境(AM) → 总线与 SoC → 后端物理设计 → GDS 版图 → 流片
```

---

# F 阶段：预学习（数字电路基础）

## F1 如何科学地提问

**本篇主题**：确立预学习的规则、心态与提问方式——这是"成为专业人士"的第一步。

**核心概念与结论**：

- **课前准备**：阅读官网《报名参与》《常见问题》，填写通识问卷（可重做，**满分 100 才能申请入学答辩**）；报名后按邮件指引创建"学习情况记录表"并每日填写（助教评价维度之一）。
- **大佬三连 STFW / RTFM / RTFSC**：Search The Friendly Web、Read The Friendly Manual、Read The Friendly Source Code。遇到先搜、先读手册、先读源码。
- **与其说学会提问，不如说学会"不提问"**：能力与你独立解决问题的投入成正比；大佬给的答案展示的是大佬的能力，不是你的能力。
- **帮助别人**：直接给答案会剥夺对方接受专业训练的机会；应当引导对方查资料/看手册/看代码，提出自己的思考。
- **AI 时代**：AI 能瞬间完成简单作业，但学习意义在于训练独立解决未知问题的能力。
- **提问渠道**：群里沟通（推荐，积极者可发展为助教）＞ 私聊助教。
- **讲义信息框**：提示、实验必做、必读信息、扩展阅读、选做思考题、选做编程题、超越实验的原则与方法等，按颜色和图标区分。

## F2 Logisim 安装和使用

**本篇主题**：安装并熟悉图形化数字电路仿真工具 **Logisim-evolution**（Logisim 升级版）。

**核心概念与结论**：

- **软件仿真四大好处**：免费、灵活（元件无限）、元件不老化、安全（无短路风险）。
- **环境**：Java 程序，跨平台；不强制使用 Linux。
- **安装**：GitHub release 下载 V4.0.0（Windows x86 选 `logisim-evolution-4.0.0-amd64.msi`，含 jdk-17）；无 GitHub 条件用官网网盘链接（讲义提供百度网盘）。
- **语言**：默认英文；可在 `File -> Preferences -> International -> Language` 切中文，但部分翻译不标准（如 library 译成"图书馆"），讲义保留英文术语。
- **入门路径**：`Help -> Tutorial` 完成 6 部分初学教程 → RTFM 阅读 `The graphical interfaces`、`Menu reference` → 阅读 `Library Reference -> Input/Output library` 了解元件。
- **常用元件**：输入 Button（按钮）、Dip Switch（拨码开关）；输出 LED、7-Segment Display（七段数码管）。

## F3 数字逻辑电路基础

**本篇主题**：回答信息的**表示、处理、存储**三个根本问题——从晶体管一路搭到寄存器/计数器/数列求和电路。**这是 F 阶段篇幅最大、最核心的一篇。**

**核心概念**：

- **数字信号 0/1**：表示信号的两种离散状态（逻辑 0/1），区别于连续的模拟信号。
- **MOSFET**：nMOS（栅源电压差大时导通）/ pMOS（相反），三端 gate/source/drain；两者互补组成 **CMOS**。
- **门电路**：非门（反相器）、与非门、与门、或非门、或门、传输门（TG）、异或门（XOR）、同或门（XNOR）。
- **对等设计原则**：输出 1 产生的电流/电压降应与输出 0 吸收的相同；使使用者只需关心逻辑功能。
- **全定制 vs 半定制**：全定制晶体管数少、面积小、频率高、功耗低，但设计难、周期长；现代多用基于标准单元的半定制（FPGA 是门阵列的例子）。
- **组合逻辑 vs 时序逻辑**：组合逻辑输出仅由当前输入决定（无记忆）；时序逻辑输出还依赖旧状态（有记忆）。
- **补码**：现代计算机表示整数的方式，可用同一加法器做加减法。

**关键机制与结论**：

1. **用电压表示 0/1**：CMOS 反相器把 n/p 管的开关特性转换成输出高低电平——高电压=逻辑 1，低电压=逻辑 0。
2. **真值表 → 逻辑表达式**：对每个输出为 1 的表项，输入为 1 取信号本身、为 0 取非，做"与"；再把各表项做"或"。例：异或 `Y = A^B = (A&~B)|(~A&B)`。卡诺图扩展性差，实际由 QMC / espresso 算法化简。
3. **门电路面积**（以等效最小晶体管数 `#T` 计，满足对等设计原则）：
   - `#T(not)=2`，`#T(nand)=#T(nor)=4`，`#T(and)=#T(or)=6`，`#T(tg)=2`（未考虑电气特性时）。
   - 考虑对等设计后：`#T(nand)=6`，`#T(nand3)`用门搭=14、用晶体管搭=12。
   - 门搭异或 `#T(xor)=22`；全定制异或可少至 14（讲义 hint），同或可少至 6。
4. **进位计数法**：二进制（前缀 `0b`）、十六进制（前缀 `0x`，1 位十六进制=4 位二进制）、八进制；短除法实现十进制定→二/十六进。
5. **基本组合逻辑模块**（含面积）：
   - **译码器**（n 选 1，独热码 One-hot，常用于寻址）：`#T(2-4 dec)=36`，面积随位宽指数增长。含七段数码管译码器（转码器）。
   - **编码器**（独热码→二进制，输入非独热则未定义 `X`；利用未定义可简化设计）：`#T(4-2 enc)`可低至 16。
   - **优先编码器**：允许多个 1，编码最高位的 1；可算前导 0/1、尾随 0/1。
   - **多路选择器 MUX**（`#T(2-1 mux)=26`，用传输门仅 6）；处理器中大量使用。
   - **比较器**（异或/同或搭建，`#T(cmp4)=48`）。
   - **加法器**：半加器 `S=A^B, C=A&B`（`#T(HA)=14`）→ 全加器（`#T(FA)=36`）→ 行波进位加法器 RCA（`#T(RCA32)=1130`）。
6. **整数机器级表示**：
   - **原码**：符号位+绝对值，加减需额外减法器与符号处理。
   - **反码**：负数取反，但存在 `-0` 问题，仍需修正。
   - **补码**：负数=取反+1；**可用 RCA 直接做加减**，故现代计算机普遍采用。用"时钟模型"可直观解释；**溢出检测**：同号相加得异号即溢出（只看符号位全加器的进位与和）。
7. **时序逻辑：从锁存到触发**：
   - **交叉配对反相器**：能存 1 bit，但无外部输入无法更新；`Q=Q̅` 时进入**亚稳态**。
   - **SR 锁存器**：S 置 1、R 置 0；`S=R=1` 禁止（亚稳态）。`#T(SR latch)=12`。
   - **D 锁存器**：加 D 与 WE（写使能）从源头避免亚稳态；电平触发，`#T=30`（门）/10（传输门）。
   - **同步电路**：全局时钟把事件划分到不同周期；要求边沿写入并稳定读出，D 锁存器（电平触发）不满足。
   - **D 触发器（主从式）**：两个 D 锁存器 + 时钟取反，上升沿采样；`#T(DFF)=22`。是同步电路基本存储元件。还有维持-阻塞式、下降沿触发、带使能端版本。
   - **寄存器**：多个共享时钟/使能的 D 触发器。可搭 4 位寄存器、计数器、数列求和电路（算 1+…+10）、电子时钟。

**重要实验/必做题**：分析门电路、画或门晶体管结构、在 Logisim 搭 2-4 译码器/七段数码管译码器/16-4(优先)编码器/4 选 1 MUX/比较器/全加器/4 位加法器/4 位减法器/原码与反码加法器、检测补码溢出、搭 SR/D 锁存器与 D 触发器、搭 4 位寄存器/计数器/数列求和电路/电子时钟。

## F4 计算机系统的状态机模型

**本篇主题**：用"状态机"统一 C 程序 / ISA / 数字电路，串起 `C 程序 → 编译 → 指令序列 → CPU 电路状态转移` 的完整链条。

**核心概念**：

- **指令 = 操作码 opcode + 操作数 operand**；**GPR**（通用寄存器：rs1/rs2 源、rd 目的、imm 立即数；PC 不属于 GPR）。
- **存储程序思想**：程序是指令序列，存于存储器，PC 指示当前位置，循环"取指→执行→更新 PC"。
- **sISA**（simple ISA）：虚构的极简指令集（3 条指令），用于对照 x86/ARM/RISC-V；ISA 是规范/模型机，不涉及实现。
- **状态机四要素**：状态集合、激励事件集合、状态转移规则（二元函数，给定状态+激励求次态）、初始状态。
- **三个层次的状态机**：C 程序（变量+PC / 执行语句）、ISA（PC+GPR+内存 / 执行指令）、数字电路（时序元件状态 / 组合逻辑）。

**关键机制与结论**：

1. **sISA 三条指令编码（8 位指令字）**：

   ```
    7  6 5  4 3   2 1   0
   +----+----+-----+-----+
   | 00 | rd | rs1 | rs2 | add:  R[rd]=R[rs1]+R[rs2]
   | 10 | rd |  imm      | li:   R[rd]=imm（高位补 0）
   | 11 |  addr   | rs2 | bner0: if (R[0]!=R[rs2]) PC=addr
   ```
   opcode 2 位（00=add,10=li,11=bner0）；4 个 GPR 用 2 位寻址。

2. **数列求和 1+2+…+10 程序**（状态记为 `(PC,r0,r1,r2,r3)`）：

   ```
   0: li r0,10      4: add r1,r1,r3    7: bner0 r3,7  # r3=1≠r0=10，自循环停机
   1: li r1,0       5: add r2,r2,r1
   2: li r2,0       6: bner0 r1,4
   3: li r3,1
   ```
   最终 **PC=7，结果 55 在 r2**。机器码：`10001010 10010000 10100000 10110001 00010111 00101001 11010001 11011111`。

3. **速度对比**：2GHz 时求 1+…+10 不到 40 条指令≈20ns；求 1+…+10000≈3 万条指令≈15μs（人工约 4889 秒）——体现计算机优势。

4. **ISA 状态机**（sISA 状态可简化为 `(PC,R[0..3])`）：如 `(5,10,1,0,1)` 执行 `00101001`（add r2,r2,r1）→ 次态 `(6,10,1,1,1)`。

5. **C 程序状态机**：状态=变量+隐含 PC，激励=执行语句，转移规则=语句语义。

6. **数字电路状态机**：状态=时序元件值；组合逻辑=激励事件；初始状态=复位状态。Johnson 计数器序列 `0000→1000→1100→1110→1111→0111→0011→0001→0000`。

7. **编译与 CPU 设计的本质**（三者对照表）：

   | | C 程序 | ISA | 数字电路 |
   |---|---|---|---|
   | 状态 | 变量 + PC | PC + GPR + 内存 | 时序逻辑电路 |
   | 激励 | 执行语句 | 执行指令 | 组合逻辑处理 |
   | 转移规则 | 语句语义 | 指令语义 | 组合逻辑逻辑 |

8. **从一到无穷大**：补码让同一加法器做加减；循环重复加/减实现乘除；科学记数法 `M×2^E` 表示小数；幂级数展开算初等函数；黎曼和算积分。

9. **指令集 ≠ 处理器**：前者是规范，后者是实现。知识产权三模式：开放免费 / 可授权 / 封闭。

**重要实验/必做题**：延续数列求和指令记录状态、编写 1+3+5+7+9 程序、C 语言 do-while 求和状态分析、Compiler Explorer 实践、从状态机视角理解编译。

## F5 支持数列求和的简单处理器

**本篇主题**：用数字电路实现 sISA 得到 **sCPU**；从"只有 li"起步，逐步加 add、bner0，理解指令周期、存储器电路与控制信号。

**核心概念**：

- **sCPU**：数字电路实现的 sISA CPU。PC 8 位、4 个 8 位 GPR。
- **指令周期**：取指 fetch → 译码 decode → 执行 execute → 更新 PC。
- **存储器**：规格 `深度×宽度`（如 2×3）；ROM（只读，取指用）/ RAM（可写，GPR 用）；地址译码器→独热码→字线/位线；单端口/多端口 RAM；写使能 EN。
- **指令译码器**：opcode 经 2-4 译码器输出独热码作**控制信号**。
- **数据通路 data path / 控制逻辑 / 控制信号 / 无关项 X（don't care）**。

**关键机制与结论**：

1. **只有 li 的 sCPU**：取指（PC+ROM，ROM 用 MUX 实现）→ 译码（位抽取得 rd/imm）→ 执行（imm 写入 rd，GPR 本质是 RAM）→ 更新 PC（计数器 +1）。
2. **完整 sCPU**：
   - add：需两个读端口 + 一个写端口访问 GPR；`wdata` 用 MUX 二选一（加法器输出 / 立即数）。
   - bner0：R[0] 通过 MUX 把 `raddr1` 置 0；比较器比较；PC 输入 MUX（跳 addr 或 PC+1）；`wen=0` 不写 GPR。
   - GPR 端口信号：读 `raddr1/rdata1`、`raddr2/rdata2`，写 `waddr/wdata/wen/clk`。
3. **控制信号表（核心结论）**：

   | 指令 | wdata 选择 | wen | raddr1 选择 | 更新 PC |
   |---|---|---|---|---|
   | add | 加法器输出 | 1 | rs1 | PC+1 |
   | li | 立即数 | 1 | X | PC+1 |
   | bner0 | X | 0 | 0 | 指令的 addr |

4. **结构划分**：以"取出的指令"为界，左侧 `PC→ROM`，右侧 `Decoder→GPR/Add/Cmp`；左侧只向右侧传递指令。**CPU 设计最关键两步：设计数据通路 + 设计控制信号**。

**重要实验/必做题**：实现取指（用 MUX 做 ROM）、实现 GPR 及写入、实现仅 li 的 sCPU、添加 add、添加 bner0（跑完求和得 PC=7、55）、与数列求和电路对比、编写奇数之和程序、论证"设计一条让 10 个数相加的指令"是否合理。

## F6 简易输入输出

**本篇主题**：为 sCPU 增加 I/O：把 sISA 增强到 **v2.0**（增强 li/bner0）、新增 **io 指令**接入外设，并引出**现代处理器设计流程**。

**核心概念**：

- **sISA v2.0**：增强 li（`s` 字段移位）、增强 bner0（相对偏移 `offset` + 符号扩展）。
- **零扩展**（高位补 0，li 用）vs **符号扩展**（高位补符号位，bner0 用）；offset 用补码表示负数。
- **io 指令**：方向位 `i/o` + 设备号 `idx`，`R[rd]<=>dev[idx]`；sISA 只定义最多关联设备数，具体设备由 sCPU 实现决定。
- **输出数据寄存器**：锁存输出数据，使 LED/数码管状态在 io 后保持不变。
- **现代处理器设计流程**：HDL 描述连接 → 仿真检查 → EDA 转版图；"处理器设计 ≠ HDL 编码"。

**关键机制与结论**：

1. **sISA v1 局限**：PC 8 位→最多 256 条指令；GPR 仅 4 个；li 只能装 0~15（装 192 需 7 条指令）；bner0 跳转仅 0~15。
2. **增强编码**：

   ```
   | 10 | rd | s | imm |   R[rd] = imm << (s << 1)         s:00→位1:0 ... 11→位7:6
   | 11 |  offset  | rs2 |   if (R[0]!=R[rs2]) PC = PC + sign_ext(offset)   跳 -8~+7
   ```
   装 192 一条即可：`10001111`。增强指令只需改**操作数译码**（其余阶段不变）。符号扩展保证补码真值不变（数学归纳法证明）。
3. **最终 sISA 4 条指令**：

   ```
   00 rd rs1 rs2   R[rd]=R[rs1]+R[rs2]
   01 rd i/o idx   R[rd]<=>dev[idx]
   10 rd s  imm    R[rd]=imm << (s << 1)
   11 offset rs2   if (R[0]!=R[rs2]) PC=PC+sign_ext(offset)
   ```
4. **sCPU 设备关联表**：写 `idx=000`→LED，`001`→七段数码管；读 `000`→拨码开关，`001`→按钮。
   - LED：不为 rd 新增读端口，而是复用已有端口并加控制信号选 rd 作读地址；加输出数据寄存器锁存。
   - 七段数码管：两个 Hex Digit Display 各显示 1 位十六进制（注意显示的是十六进制）。
   - 拨码开关/按钮：输入设备状态由用户设定，无需暂存寄存器。
5. **Logisim 三大缺陷**：设计繁琐（现代处理器上千条指令、手册几千页）、仿真慢、调试难 → 催生 HDL + 仿真 + EDA 流程。

**重要实验/必做题**：实现增强指令并重算求和、输出到 LED、输出到七段数码管、从拨码开关读入末项、末项为 0 的分析、按钮控制显示、单步求和（hint：12 条指令方案）、单步求和(2)。

## F7 F 阶段流片准备（建设中）

**本篇主题**：等待云平台上线，暂无实质内容。

---

# E 阶段：预学习（HDL 与处理器）

## E1 硬件描述语言

**本篇主题**：从 Logisim 过渡到 **Verilog HDL**——现代处理器都是用 HDL 设计的。

**核心概念与结论**：

- **电路思维的延续**：数字电路设计只做"实例化"和"连线"；HDL 只是换了方式，头脑中必须能把代码对应到电路结构，否则会设计出频率低/面积大/功耗高甚至功能错误的电路。
- **推荐资料**：《数字电路与计算机体系结构》1~5 章、Verilog 入门视频、Verilog 语法简介、中科大 Verilog OJ。
- **HDLBits 在线练习**（<https://hdlbits.01xz.net>）：
  - 高手可直接挑战：Sequential Logic、Finite State Machines、Lemmings 1-4、PS/2 packet parser、Serial receiver 系列。
  - 基础路线：Getting Started → Verilog Language → Combinational Logic（门/真值表/Thermostat/population count）→ Multiplexers → Arithmetic Circuits（有符号溢出、100 位加法器）→ Sequential Logic（DFF/各种复位/边沿检测）→ Counters → Shift Registers（LFSR）→ More Circuits（全部）→ FSM（全部）。
- **Verilog ↔ 电路图关联**：在 Logisim 中生成对应电路的 Verilog 代码，阅读并理解代码如何对应电路。

## E2 C 语言程序设计

**本篇主题**：掌握 C 语言以理解"程序如何在处理器上运行"。

**核心概念与结论**：

- **必掌握**：递归、指针、链表，并能**独立写出正确程序**（而非搜索示例代码）。
- **学习路径**：在 Compiler Explorer 在线运行；系统学习《Linux C 编程一站式学习》第 1~9、11~16、21、23~25 章及第 26 章第 1 节（链表），完成所有习题并保存代码到本地（安装 Linux 后要重跑部分代码）。
- **免修条件**：能不参考任何代码独立编写并调试一个链表程序。
- **推荐书**：《The C Programming Language》（作者 Dennis M. Ritchie 才是真正的 C 语言之父）、C Coding Standard、SEI CERT C、《Learn C the hard way》。

## E3 Linux 系统安装和基本使用

**本篇主题**：搭建 Linux 开发环境，获取框架代码，树立学术诚信与独立解决问题的价值观。

**核心概念与结论**：

- **文档即代码**：讲义复用南京大学 PA（"计算机系统基础"）讲义，采用跳转式管理，PA 讲义中尽量少提"一生一芯"。
- **STFW / RTFM / RTFSC**：本课程反复强调的自主求解方式。
- **学术诚信**（引用 MIT 定义）：要求实现 X 时，必须在不复用任何外部资源的情况下独立实现 X；分享代码和交换测试用例都不合适。
- **反对"耍小聪明"**：不用虚拟机镜像、一键脚本、PA 攻略、往期代码；"看懂"与"自己独立完成"效果天差地别；参考内容会成为学习上界并制造"我学得好"的错觉。
- **框架代码获取**：
  - 先在 GitHub 添加 ssh key（STFW）。
  - `git clone -b master git@github.com:OSCPU/ysyx-workbench.git`
  - 把 `ysyx-workbench` 当作 PA 讲义中的项目目录（即把 `ics2022` 视为 `ysyx-workbench`）。
  - 修改 `ysyx-workbench/Makefile` 中的学号和姓名——**学号可先不改**，完成预学习后再改。
- **Linux 工具**：推荐 MIT《The Missing Semester of Your CS Education》（有中文版、B 站视频）。
- **C 语言进阶**：在 Linux 上完成《Learn C the hard way》练习 **0~22、24~25、27~33**（拷贝代码编译运行、RTFSC、完成附加题），含 Makefile、Valgrind；**这是入学答辩的一部分**。

**重要实验/必做题**：MIT Missing Semester（shell/工具脚本/Vim/数据整理/命令行环境/Git）、《Learn C the hard way》上述练习；补充《The Art of Command Line》《Linux101》。

## E4 处理器的仿真和验证

**本篇主题**：用 **Verilator** 搭建 RTL 仿真环境，从组合/时序电路仿真、波形、NVBoard、静态检查，到用 RTL 实现 sCPU 并用 **DiffTest** 验证。

**核心概念**：

- **NPC**（New Processor Core）：框架默认目录 `npc`，用户处理器统称，环境变量 `NPC_HOME`。
- **Verilator**：开源 Verilog 仿真器，把 Verilog 编译成 C++ 再编译成可执行文件运行。
- **DUT / REF**：Design Under Test（被测处理器）与 Reference（功能相同、实现不同的参考实现）。
- **DiffTest**（差分测试）：DUT 与 REF 接受相同有定义输入，观测行为是否一致，不一致即 DUT 有 bug。
- **指令集模拟器**：用程序执行程序的模拟器；仅从 ISA 层面实现指令行为的称指令集模拟器。
- **设计流程**：新需求 → 架构设计 → 逻辑设计 → 功能验证 → 电路评估。

**关键机制与结论**：

1. **环境初始化**：`cd ysyx-workbench && bash init.sh npc`；目录 `npc/csrc/main.cpp`、`npc/Makefile`、`npc/vsrc/example.v`。
2. **Verilator 安装**：官网从 git 安装 stable 版（不用 apt 老版本）；在 `ysyx-workbench/` 之外操作以免被 git 追踪；`verilator --version` 验证。
3. **双控开关（组合逻辑）**：`assign f = a ^ b;`，C++ 驱动随机赋值、`eval()`、`assert(top->f == (a^b))`；无结束语句用 Ctrl+C 退出。
4. **波形**：GTKWave（`apt-get install gtkwave`）；**FST 格式约为 VCD 的 1/50**；Ctrl+F 查手册；不要长时间生成波形（占磁盘）。
5. **Makefile**：编写 `sim` 规则实现 `make sim`；**必须保留** `$(call git_commit, "sim RTL")`（原创性依据）。
6. **NVBoard**（南大虚拟 FPGA 板）：`bash init.sh nvboard`；支持拨码开关/LED/VGA；从 `make` 命令入手理解工作方式；需分配引脚、改 `npc/Makefile`。
7. **流水灯（时序逻辑）**：`light` 模块（`count`、`led<={led[14:0],led[15]}`、`count>=5000000` 清零）；仿真需 `single_cycle()` 与 `reset(int n)`（如 `reset(10)`）。
8. **静态检查 lint**：`verilator --lint-only`（只检查不生成 C++）+ `-Wall`；逻辑警告改代码，风格警告 `-Wno-xxx`（如 `-Wno-DECLFILENAME`）；建议总是开启。
9. **Chisel**：可生成等价 Verilog 经 Verilator 仿真；`bash init.sh npc-chisel`；建议先搭好 Verilog 流程再切 Chisel。
10. **代码风格规范**（重要）：
    - 未深入理解 Verilog 事件模型前**不要行为建模**，不建议写任何 `always` 语句——回归"描述电路=实例化+连线"。提供 `Reg #(WIDTH,RESET_VAL)` 触发器模板和 `MuxKey`/`MuxKeyWithDefault` 模板。
    - 坚持行为建模时**不要用 negedge**（时序收敛困难，可能被移出流片名单），只用 posedge。
    - 坚持行为建模时**不要用锁存器 Latch**（不受时钟驱动，时序难分析）。
11. **sCPU → DiffTest 流程**：
    - sEMU（simple EMUlator）用 C 变量实现 ISA 状态：`uint8_t PC=0; uint8_t R[4]; uint8_t M[256];`；`inst_cycle()` 完成取指/译码/执行/更新 PC；主循环 `while(1){inst_cycle();}`。
    - 模拟器的价值：不必管电路/连线/时序/面积/功耗，适合理解 ISA 与程序行为、功能验证、程序分析、调试、设计空间探索。
    - DiffTest 伪代码：`dut_single_cycle(); ref_inst_cycle(); ...check_regs(...)`；`&top->rootp->NPC__DOT__gpr_ext__DOT__Memory` 是 Verilator 编译后访问 GPR 的变量名（RTL 变化需同步修改）。
    - 改造要点：去掉 sEMU 的 main()，`.c` 改 `.cpp`，加入 verilator 文件列表。

**重要实验/必做题**：双控开关仿真与波形、`make sim` 规则、NVBoard 双控开关与流水灯、静态检查、南大数电实验（译码器/编码器/加法器 ALU/移位寄存器桶形移位器/状态机键盘/VGA）、RTL 实现 sCPU 算求和并 io 输出到 LED、实现 sEMU、sCPU 与 sEMU 做 DiffTest（含故障注入、完善报错、纳入 PC 比较）。

## E5 功能完备的迷你 RISC-V 处理器

**本篇主题**：从 sISA 升级到 **minirv**（8 条 RISC-V 指令的迷你子集）——先做指令集模拟器 minirvEMU，再用模块化 RTL 实现 minirv NPC（含 DPI-C 访存与 ebreak 结束机制）。

**核心概念**：

- **RISC-V 模块化 ISA**：基础集 **RV32I（42 条指令）**，扩展有乘除/浮点/原子；minirv 从中选 **8 条**：`add`、`addi`、`lui`、`lw`、`lbu`、`sw`、`sb`、`jalr`。
- **minirvEMU / minirv NPC**：分别为 C 语言模拟器与 RTL 处理器。
- **模块化 RTL 单元**：IFU（取指）、IDU（译码与控制）、EXU（ALU）、LSU（访存）、WBU（写回/更新 PC）。
- **DPI-C**：借用 SystemVerilog DPI-C 实现 RTL 与 C++ 仿真环境交互（ebreak 通知、访存）。
- **ABI 助记符**：`zero`/`a0`/`ra` 等功能名表示 GPR 编号；**不对齐访存**：`addr % w == 0` 为对齐（lw/sw 的 w=4）。

**关键机制与结论**：

1. **sISA 局限**（引出 minirv）：PC 8 位→256 条；GPR 8 位→数据≤255；无 GPR 间减法/乘除。
2. **minirv 规范**：PC 初值 0；GPR 数量与 **RV32E** 一致（16 个）；8 条指令；其余 ISA 细节同 RV32I。RTFM 问题：PC/GPR 位宽、`R[0]` 恒 0、指令编码位宽与 6 种基本格式、RV32E 与 RV32I 差异。
3. **minirvEMU 实现要点**：
   - 先做 `addi`、`jalr`：译码 `is_addi = (inst[6:0]==?) && (inst[14:12]==?)`（查手册第 34 章）；立即数需符号扩展；PC 每次 +4。
   - 测试程序（`a0` 最终=30）：
     ```
     0: 01400513  addi a0,zero,20
     4: 010000e7  jalr ra,16(zero)
     8: 00c000e7  jalr ra,12(zero)
     c: 00c00067  jalr zero,12(zero)   # halt 自循环
     10:00a50513  addi a0,a0,10
     14:00008067  jalr zero,0(ra)
     ```
   - 访存 4 条 `lw/lbu/sw/sb`（忽略不对齐）；小端验证：`M` 放 `0x12345678`，`lbu` 依次读出 `78 56 34 12`；`sb` 写 `90 ab cd ef` 后 `lw` 得 `0x90abcdef`。
   - **ebreak 结束机制**：约定执行 `ebreak` 程序结束并输出提示，手动把编码写入 `M`。
4. **minirv NPC 实现要点**：
   - 存储器**不用 RTL 实现，用 C++ 实现**；简化取指 `top->inst = pmem_read(top->pc);`。
   - `RegisterFile` 模板（`reg [DATA_WIDTH-1:0] rf [2**ADDR_WIDTH-1:0]; always @(posedge clk) if(wen) rf[waddr]<=wdata;`），需自行实现 `x0` 恒 0。
   - **DPI-C 访存接口**（因访存信号依赖当前指令，仿真环境不知该依赖）：

     ```systemverilog
     import "DPI-C" function int pmem_read(input int raddr);
     import "DPI-C" function void pmem_write(input int waddr, input int wdata, input byte wmask);
     ```
     C++ 侧模拟 **32 位总线、4 字节对齐**；`wmask` 每比特对应 wdata 一个字节（`wmask=0x3` 只写最低 2 字节）。好处：便于行为模型模拟设备、将来接总线改动少。
   - DPI-C 实现 ebreak：执行 ebreak 时通知仿真环境结束；Chisel 可用 BlackBox 调用 Verilog 再经 DPI-C 交互。

**重要实验/必做题**：RTFM 回答 RV32I 问题、实现仅 addi/jalr 的 minirvEMU（含负立即数测符号扩展）、实现完整 minirvEMU（含小端测试）、加 ebreak、NPC 实现 addi/jalr（含 x0）、DPI-C 实现 ebreak、DPI-C 访存补齐剩余 6 条指令、Chisel DPI-C 与 BlackBox。

## E6 简易运行时环境

**本篇主题**：引入项目 **abstract-machine（AM）** 提供的裸机运行时环境，让 minirv NPC 能运行复杂程序；搭建编译—装载—批量测试—外设模拟—性能评测流程，并用 ECC/yosys 综合评估频率。

**核心概念**：

- **AM（abstract-machine）**：通过 `ARCH` 参数把同一程序编译到不同平台：`native`（Linux）、`riscv32-nemu`、`minirv-npc`（本篇重点）。
- **类比**：`fceux` 模拟 6502 运行红白机游戏，本质与 sEMU/minirvEMU 相同；AM 可把 fceux 交叉编译到 minirv。
- **交叉编译工具链**：`apt install g++-riscv64-linux-gnu`。
- **编译产物**（以 dummy 为例）：`dummy-minirv-npc.bin`（二进制）、`.txt`（反汇编）、`.elf`。
- **程序约定**：入口 `0x80000000`（以下地址留给设备）；结束前写 `a0` 再 `ebreak`，输出 `HIT GOOD TRAP`（a0=0）或 `HIT BAD TRAP`（a0≠0）。
- **内存映射 I/O（MMIO）**：用 load/store 访问外设，靠地址区分：UART 数据 `0x10000000`、UART 状态 `0x10000004`、时钟低/高 `0x20000000/0x20000004`；C 用 `volatile` 指针防优化。
- **测试集**：riscv-tests、cpu-tests、`klib-minirv-npc.a`（放 `abstract-machine/klib/build/`，需 `touch` 更新时间戳）。
- **Benchmark**：dhrystone、coremark、microbench、archbench（test/train/ref/huge，含 `202.llama2`）；**几何平均**通常作为最终结果，train 规模默认评测（test 仅测功能）。
- **ECC + yosys + ICsprout55 PDK + oss-cad-suite**：`ecc.toml` 配置 `[design]/[pdk]/[flow]/[pdk.overrides]`；preset 可选 `rtl2gds|rcx|harden|syn_sta`；报告 `qor_summary.rpt`（频率/面积在 CELLA 列）、`power.rpt`、`Synthesis.log`、网表 `xxx_Synthesis.v.gz` / 仿真网表 `xxx_Synthesis_sim.v.gz`；综合策略 DELAY/AREA/BALANCE（默认 BALANCE 3），`YOSYS_SYNTH_STRATEGY="DELAY 0"`；不可综合代码用 `` `ifndef SYNTHESIS `` 包围。

**关键机制与结论**：

1. **装载程序**：PC 复位值改 `0x80000000`；`pmem_read/write()` 按 addr 距 `0x80000000` 的偏移访问；存储器建议 128MB。
2. **自动结束**：`abstract-machine/am/src/riscv/npc/trm.c` 的 `halt()` 中内联汇编 `asm volatile("ebreak")`，进一步 `asm volatile("mv a0, %0; ebreak" : :"r"(code))`。
3. **Makefile 感知结果**：`wrong` 在 native 显示 FAIL、在 minirv-npc 却 PASS，因仿真环境未把错误返回；修复：让仿真 `main()` 按结果返回不同值（成功 0、失败非 0）。
4. **UART 行为模型**：`pmem_write()` 中 `waddr==0x10000000` 时 `fputc(wdata&0xff, stderr)`；状态用 `(rand()&0x7)==0` 随机模拟（12.5% 就绪）；DiffTest 需识别写串口的 store 并忽略、把状态 load 值拷贝到 minirvEMU。
5. **计时与性能**：`gettimeofday()` 是主机真实时间，不能代表 NPC 性能；应按"仿真周期数 ÷ NPC 频率"换算，前端先假设 100MHz。
6. **综合前调整 NPC**：存储器不属于 NPC，把 DPI-C 访存移到 NPC 外部、访存信号连顶层；多文件用 `rtl=["rtl/filelist.f"]`（列出 IFU/IDU/EXU/LSU/WBU.v）。

**重要实验/必做题**：体验 AM（红白机游戏）、编译运行 dummy/wrong/hello、让仿真输出 HIT GOOD/BAD TRAP、让 run 规则自动仿真并感知结果、运行 riscv-tests 并加 DiffTest、运行 cpu-tests、UART 模型与 putch 输出 hello、跑 benchmark、跑 LLaMa（test 输出 Once、train 约 5 分钟）、UART 状态寄存器、时钟与 `__am_timer_uptime()`、性能评测与综合频率评估。

## E7 简易总线和 SoC

**本篇主题**：从 DPI-C 行为模型转向真实硬件通信——引入 **SimpleBus** 协议，支持有延迟访存，接入 **ysyxSoC**（AXI/APB 桥 + 真实设备），访问 UART16550/GPIO/CSR，完成频率校准与性能评测。

**核心概念**：

- **总线**：通信协议，含协议层次（master/slave 达成一致）与实现层次（电路实现）；连接处理器/存储器/设备的称系统总线。
- **DPI-C 局限**：无读延迟；真实访存有延迟，需识别回复到达、等待期间不执行指令、告知存储器何时取指。工业级 AXI 约 30+ 信号，故先用简化 **SimpleBus**。
- **IPC**：每周期执行指令数；当前单周期处理器 IPC=1。
- **存储器**：ROM/SRAM（Nx32），同步存储器读延迟固定 1 周期；可读写存储器信号 `wen/ren/wmask[3:0]`/`reqValid`/`respValid`。
- **ysyxSoC 架构**：NPC ←SimpleBus→ Memory Bridge → AXI-to-APB Bridge → APB XBar → UART / SPI(→Flash) / PSRAM。含 SimpleBus→AXI 转接桥。
- **SoC 地址空间**：UART16550 `0x1000_0000~0x1000_0fff`、SPI `0x1000_1000~0x1000_1fff`、Flash `0x3000_0000~0x3fff_ffff`、PSRAM `0x8000_0000~0x807f_ffff`。
- **接口规范**：`ysyxSoC/ready-to-run/minirv/cpu-interface.md`；`io_lsu_size`：1 字节 `2'b00`、2 字节 `2'b01`、4 字节 `2'b10`。
- **加载器**：`.bin` 含 loader（位于 `0x30000000`），把程序从 Flash 加载到 PSRAM `0x80000000` 再跳转；`gen.sh` 负责拼接。
- **UART16550**：配置如 `115200 8N1`；**16 倍过采样**（连续≥8 次低认定起始位）；`除数 = 频率 / 波特率 / 16`（50MHz/115200→27.13，取整 27 有误差）。
- **GPIO**：APB 接口，映射 `0x2000_1000~0x2000_100f`：LED(16 位)/拨码开关(16 位)/数码管(32 位)/保留；实现 `mygpio_top_apb.v`。
- **CSR**：12 位地址空间（4096 个），指令原子读写；`mvendorid`=`0x79737978`（"ysyx"）、`marchid`=学号、`mcycle/mcycleh`（RV32 拆 64 位）；`csrr` 伪指令展开为 `csrrs`。
- **频率校准**：PSRAM(IS66WVS4M8ALL) 最高 33MHz；用 **PLL** 倍频（低频 25MHz 驱动 SoC/外设，高频如 500MHz 驱动 NPC，k=20）。

**关键机制与结论**：

1. **SimpleBus 读时序（1 周期延迟）**：idle 态发 `ifu_raddr=pc` 转 wait，wait 态把 `ifu_rdata` 当有效指令。**NPC 由单周期变多周期**（第 1 周期发请求，第 2 周期拿指令执行）。让处理器"不执行指令"=让时序元件写使能无效。
2. **LSU 写操作**：`M[addr]=(wdata&wmask_full)|M[addr]&~wmask_full`；load 需 3 周期；DiffTest 仅在指令结束时检查（DPI-C 读状态判断时机）。
3. **有效信号状态机**：idle 态需访存则置 `reqValid/addr` 转 wait；wait 态 `respValid` 有效则用 rdata 继续转 idle，否则等待。
4. **健壮性验证**：依次加 5/10/20 周期延迟，再用 LFSR 伪随机决定延迟，仍能正确运行即证明总线可靠。
5. **接入 ysyxSoC 要点**：PC 复位值改 `0x3000_0000`；所有 `.v/.sv` 加文件列表、uart/spi rtl 加 include 路径；`clock` 与 `cpuClock` 同频；`ElaborateTop.v` 中换处理器模块名；加 `extern "C" void flash_read(...){assert(0);}`。
6. **启动流程**：Flash 中 loader 把程序加载到 PSRAM 并输出 `loading to memory region [0x80000000, ...)` 后跳转。
7. **结论性思考**：频率校准后 k=1 与最大 k 下性能几乎不变（收益被外设速度抵消）——单纯优化处理器频率不值得。
8. **仿真权衡**：`minirv-npc` 适合功能调试；`minirv-ysyxsoc` 更接近真实芯片，适合性能评测。minirv 把非 minirv 指令翻译成多条等价指令，效率比 RV32I 低数倍到数十倍。

**重要实验/必做题**：测 IPC、支持 SimpleBus 的 IFU/LSU（含 DiffTest 适配多周期）、有效信号协议、随机延迟测试、接入 ysyxSoC、运行 hello/dummy/cpu-tests/riscv-tests、UART 除数计算与初始化、TX 接 NVBoard、流水灯/密码锁/数码管展示学号、CSR 与 mcycle、时钟测试、性能表现测量、"优化频率是否值得"思考题。

## E8 后端物理设计和流片准备

**本篇主题**：完成前端准备与多重验证后，用 **ECOS Studio** 对 NPC 网表做后端物理设计，从网表生成可流片的 **GDS 版图**并导出签核包。注意：流片时所有学生**共享同一个 ysyxSoC**（基于版图集成），只需单独对 NPC 综合与后端。

**核心概念**：

- **前端准备工作**：开放地址空间、去下降沿时钟、去锁存器、命名修改（旧方案）、静态检查、复位与四值仿真、网表仿真。
- **开放地址空间**：让所有地址读写请求都经 NPC 对外 SimpleBus 发出，避免提前拦截导致回片后无法访问更多设备。
- **下降沿时钟 / 锁存器**：混用边沿加大时序收敛难度；锁存器（ICsprout55 中 `LAT*` 开头）时序难分析。
- **触发器复位**：系统复位行为必须与随机存储器内容无关；只需复位最小子集（两类可不复位：软件可初始化的 ISA 寄存器、不影响复位后行为的数据通路触发器）。
- **四值仿真**：verilator 二值（0/1）无法暴露未复位触发器；**iverilog（ICARUS verilog）**支持四值 `X` 传播；正确设计中 X 被控制信号遏制并收敛。
- **VPI 机制**：iverilog 不支持 DPI-C，用 VPI 注册系统任务 `$pmem_read/$pmem_write`；编译时自动定义 `__ICARUS__`；用 `-s` 指定顶层、`-g2012`；Chisel 需 `firtool --lowering-options=disallowLocalVariables,disallowPackedArrays`。
- **网表仿真**：综合把 RTL 转成逻辑等价标准单元，连接关系文件为**网表**。两种网表：`xxx_Synthesis_sim.v.gz`（面向仿真，端口同综合前）、`xxx_Synthesis.v.gz`（面向后端，向量端口拆单 bit）。verilator 选项 `--timescale "1ns/1ns" --no-timing -D__VERILATOR__ -Dfunctional`。难点：DPI-C 不可综合、寄存器堆难拼接，难以用 DiffTest 定位。
- **ECOS Studio v0.1.0-alpha.9**：GUI 后端物理设计工具。关键概念：Floorplan、DASHBOARD、Flow status、Step Configuration、Key Metrics（Die Area/Frequency）、签核包 Signoff Package、STA/DRC/LVS、`config.macro_locations`。
- **后端频率低于综合频率的原因**：①后端计入标准单元间走线延迟；②后端按极端环境计算更悲观。

**关键机制与结论**：

1. **验证链条（由易到难）**：RTL 仿真(verilator+DiffTest) → 四值仿真(iverilog 查 X) → verilator 网表仿真 → iverilog 网表仿真 → 后端物理设计。改过代码要回到前面重检。
2. **iverilog 改造要点**：PC 复位 `0x80000000`（或放跳转指令）；识别 ebreak 用 `$display()`/`$finish`/`$fatal`；关 DiffTest；写仿真顶层（如 `initial begin clock=0; reset=1; #10 reset=0; end`、`always #1 clock=~clock;`）。
3. **ECOS Studio 建 Workspace 流程**：
   - Project Setup（Create Project → 输入名称/路径）
   - Basic Info（Workspace Name）
   - Flow Setup（START STEP 选 **Floorplan**，跳过 Synthesis）
   - Design Files（Import Verilog 选 ECC 综合网表 `light/runs/default/Synthesis_yosys/output/light_Synthesis.v.gz`，**不含 `_sim`**）
   - PDK Config（Import PDK 指向 ICsprout55，Default Config）
   - Spec Setting（Design Name / Top Module Name / Clock Signal Name 须一致；Frequency max [MHz] / Origin Core Utilization）→ Create Workspace
   - 在 DASHBOARD 的 Flow status 依次运行所有步骤。
4. **导出签核包**：File → Export Signoff Package → Review；`Risk Details` 中缺 `config.macro_locations` 属正常（无宏单元），不应有其他警告；Export Package。
5. **不达标处理**：Checklist → Sign-off details；STA 不达标→设更小目标频率；DRC/LVS 不达标→设更小利用率；用 New/Update Workspace 改参数重做。

**重要实验/必做题**：开放地址空间、去下降沿时钟、去锁存器、verilator `--lint-only -Wall`、iverilog 简单示例、VPI 实现访存、检查未复位触发器影响、四值仿真查 X 传播、verilator/iverilog 网表仿真、改代码后重检、ECOS Studio 后端物理设计生成签核包、探索能成功生成签核包的最大利用率。

## E9 提交入学答辩申请

**本篇主题**：预学习收官——心态转变、读后感与提交申请。

**核心概念与结论**：

- **感受到独立解决问题的快乐**：不仅能力肉眼可见提升，内心也变强、不再害怕未知问题——这个心态转变至关重要。
- **读后感**：仔细阅读《提问的智慧》《别像弱智一样提问》，结合预学习阶段提问/被提问经历，写**不少于 800 字**读后感，谈对"好的提问"及通过 STFW/RTFM/RTFSC 独立解决问题的看法。
- **提交申请**：根据《"一生一芯"入学答辩申请指引》完成相应内容并提交。注意申请表中需提交的数电实验截图是 **E5 阶段"借助 NVBoard 完成数字电路实验"**，而非 F 阶段数电题。

---

# 附录：核心概念速查表

### 指令集演进

| 阶段 | 名称 | 指令 | 特征 |
|---|---|---|---|
| F4/F5 | sISA v1 | add / li / bner0（3 条） | 8 位指令字，PC 8 位，4 个 8 位 GPR |
| F6 | sISA v2 | + io（4 条） | 增强 li(移位)、bner0(相对偏移)，接外设 |
| E5 | minirv | add/addi/lui/lw/lbu/sw/sb/jalr（8 条） | RV32I 子集，GPR 同 RV32E，PC+4，字节寻址 |

### 工具链与平台

| 名称 | 用途 |
|---|---|
| Logisim-evolution | F 阶段图形化数字电路设计与仿真 |
| Verilator | 把 Verilog 编译成 C++ 仿真（二值、快）；`--lint-only` 静态检查 |
| GTKWave | 波形查看（FST 格式约为 VCD 的 1/50） |
| iverilog (Icarus) | 四值仿真（查 X 传播），用 VPI 替代 DPI-C |
| NVBoard | 南大虚拟 FPGA 板，拨码开关/LED/VGA |
| DiffTest | DUT 与 REF 差分测试，验证处理器功能 |
| AM (abstract-machine) | 裸机运行时环境，`ARCH=native/riscv32-nemu/minirv-npc` |
| DPI-C | RTL 与 C++ 仿真环境交互（访存、ebreak） |
| SimpleBus | 简化的总线协议（master/slave + reqValid/respValid） |
| ysyxSoC | 含 AXI/APB 桥与 UART/SPI/PSRAM 的真实 SoC |
| ECC / yosys / ECOS Studio | 综合与后端物理设计（网表→GDS→签核包） |

### 关键地址与约定

| 项目 | 值 |
|---|---|
| 程序入口 | `0x80000000`（minirv-npc）；`0x3000_0000`（接 ysyxSoC，从 Flash 复位） |
| 结束约定 | 写 a0 后 ebreak；HIT GOOD TRAP(a0=0) / HIT BAD TRAP(a0≠0) |
| UART 数据/状态 | `0x10000000` / `0x10000004` |
| 时钟低/高 | `0x20000000` / `0x20000004` |
| Flash / PSRAM | `0x3000_0000~0x3fff_ffff` / `0x8000_0000~0x807f_ffff` |
| GPIO | `0x2000_1000~0x2000_100f`（LED/开关/数码管/保留） |
| CSR | `mvendorid=0x79737978`("ysyx")、`marchid`=学号、`mcycle/mcycleh` |

### 面积估算速记（#T，等效最小晶体管数）

| 门/模块 | #T | 门/模块 | #T |
|---|---|---|---|
| not | 2 | xor（门搭） | 22 |
| nand / nor | 4→6 | xor（全定制）≤14 |
| and / or | 6→8 | FA | 36 |
| tg | 2 | RCA32 | 1130 |
| D latch | 10(传输门) | DFF | 22 |
| SR latch | 12 | 2-1 MUX | 6(传输门)/26 |

### 学习方法口诀

- **STFW / RTFM / RTFSC**：搜网络、读手册、读源码——独立解决问题三板斧。
- **状态机视角**：状态 + 激励 → 次态；编译与 CPU 设计都是状态机之间的翻译/实现。
- **实例化 + 连线**：HDL 代码要能在头脑中想象成电路结构。
- **机器永远是对的**：不理解多因没吃透手册细节，质疑要拿证据。
- **可综合代码规范**：不用 always 行为建模（除非深入理解）、不用 negedge、不用 latch。

---

> 文档说明：本总结基于 v26.07 版讲义整理。F7（流片准备）当前为"建设中"。个别数值单位在原讲义抓取中被截断（如 E6 面积单位、E7 流片报价单位），已按原文保留。完整细节请以官网讲义原文为准：<https://ysyx.oscc.cc/docs/>。

