import 'package:flutter/material.dart' show BuildContext, TimeOfDay;

import 'package:openjmu_lite/apis/date_api.dart';
import 'package:openjmu_lite/beans/bean.dart';


enum CourseType {
    ///
    /// [Course] for current day.
    /// This type of course will only display courses
    /// belong to the current ***day***.
    ///
    today,
    ///
    /// [Course] for current week.
    /// This type of course will only display courses
    /// belong to the current ***week***.
    ///
    week,
    ///
    /// [Course] for current term.
    /// This type of course will only display courses
    /// belong to the current ***term***.
    ///
    term
}

class CourseAPI {
    static TimeOfDay _time(int hour, int minute) => TimeOfDay(hour: hour, minute: minute);
    static double _timeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

    static bool inCurrentTime(Course course) {
        double timeNow = _timeToDouble(TimeOfDay.now());
        List<TimeOfDay> times = courseTime[course.time];
        double start = _timeToDouble(times[0]);
        double end = _timeToDouble(times[1]);
        return start <= timeNow && end >= timeNow;
    }
    static bool inCurrentDay(Course course) {
        DateTime now = DateTime.now();
        return course.day == now.weekday;
    }
    static bool inCurrentWeek(Course course) {
        return DateAPI.currentWeek >= course.startWeek && DateAPI.currentWeek <= course.endWeek;
    }
    static bool isActive(Course course) {
        return inCurrentTime(course) && inCurrentDay(course) && inCurrentWeek(course);
    }

    static Map<String, List<TimeOfDay>> courseTime = {
        "12": [_time(08, 00), _time(09, 35)],
        "34": [_time(10, 05), _time(11, 40)],
        "56": [_time(14, 00), _time(15, 35)],
        "78": [_time(15, 55), _time(17, 30)],
        "910": [_time(19, 00), _time(20, 45)],
        "11": [_time(20, 50), _time(21, 25)],
    };
    static Map<String, String> courseTimeChinese = {
        "12": "一二节",
        "34": "三四节",
        "56": "五六节",
        "78": "七八节",
        "910": "九十节",
        "11": "十一节",
    };
    static Map<int, String> courseDayTime = {
        1: "一", 2: "二", 3: "三", 4: "四", 5: "五", 6: "六", 7: "日",
    };

    static String getCourseTime(BuildContext context, Course course, CourseType type) {
        List<TimeOfDay> times = courseTime[course.time];
        TimeOfDay start = times[0], end = times[1];
        String result;
        switch (type) {
            case CourseType.today:
                result = "${start.format(context)} - ${end.format(context)}　${courseTimeChinese[course.time]}";
                break;
            case CourseType.week:
                result = "${start.format(context)} - ${end.format(context)}　星期${courseDayTime[course.day]}";
                break;
            case CourseType.term:
                result = "${start.format(context)} - ${end.format(context)}"
                        "　"
                        "周${courseDayTime[course.day]}"
                        "　"
                        "${course.startWeek}-${course.endWeek}周"
                ;
                break;
        }
        return result;
    }

    static String getCourseLocation(BuildContext context, Course course, CourseType type) {
        String location = course.location;
        String result;
        switch (type) {
            case CourseType.term:
                result = "${courseTimeChinese[course.time]}　${course.location}";
                break;
            default:
                result = "$location";
        }
        return result;
    }
}