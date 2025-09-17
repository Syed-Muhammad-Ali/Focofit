import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/profile/components/StatItem.dart';
import 'package:focofit/views/widgets/app_tab_bar.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';





class ChartSection extends StatefulWidget {
  final String title;
  final List<StatItem> stats;
  final List<List<double>> data;
  final List<String> weekDays;
  final List<Color> colors;
  final List<String>? legends;
  final Widget? extraContent;
  final double maxY;

  const ChartSection({
    super.key,
    required this.title,
    required this.stats,
    required this.data,
    required this.weekDays,
    required this.colors,
    this.legends,
    this.extraContent,
    this.maxY = 100,
  });

  @override
  State<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        AppText(
          widget.title,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
        SizedBox(height: height * 0.01),
        DiaryContainerTile(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.stats.map((s) => s.build()).toList(),
              ),
              SizedBox(height: height * 0.02),
              _buildTabs(),
              if (widget.legends != null && widget.legends!.isNotEmpty) ...[
                SizedBox(height: height * 0.02),
                _buildLegend(),
              ],
              SizedBox(height: height * 0.02),
              SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    maxY: widget.maxY,
                    minY: 0,
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      show: true,
                      getDrawingHorizontalLine:
                          (value) => FlLine(
                            color: Colors.grey.shade300,
                            strokeWidth: 1,
                          ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          // interval: 10,
                          getTitlesWidget: (value, meta) {
                            return AppText(
                              value.toInt().toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textColor,
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index < 0 || index >= widget.weekDays.length) {
                              return Container();
                            }
                            String full = widget.weekDays[index];
                            List<String> parts = full.split("\n");
                            return Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText(
                                    parts[0],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textColor,
                                  ),
                                  AppText(
                                    parts[1],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    barGroups: List.generate(widget.weekDays.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: List.generate(widget.data.length, (i) {
                          return BarChartRodData(
                            toY: widget.data[i][index],
                            color: widget.colors[i],
                            width: 5,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          );
                        }),
                        barsSpace: 6,
                      );
                    }),
                  ),
                ),
              ),
              if (widget.extraContent != null) ...[
                SizedBox(height: height * 0.02),
                widget.extraContent!,
              ],
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }

  Widget _buildTabs() {
    return DiaryContainerTile(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: CustomTabBar(
              title: "Week",
              isSelected: selectedTabIndex == 0,
              onTap: () => setState(() => selectedTabIndex = 0),
            ),
          ),
          Expanded(
            child: CustomTabBar(
              title: "Month",
              isSelected: selectedTabIndex == 1,
              onTap: () => setState(() => selectedTabIndex = 1),
            ),
          ),
          Expanded(
            child: CustomTabBar(
              title: "Year",
              isSelected: selectedTabIndex == 2,
              onTap: () => setState(() => selectedTabIndex = 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.legends!.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 5,
                decoration: BoxDecoration(
                  color: widget.colors[index],
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(width: 6),
              AppText(
                widget.legends![index],
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.textColor,
              ),
            ],
          ),
        );
      }),
    );
  }
}