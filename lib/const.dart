
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/webSocket.dart';

const domain =
    'http://server_ip:8003/unimatch-api/';
final appBarTextColor = Colors.grey.shade800;
late TutorialCoachMark tutorialCoachMark;
late BuildContext currentContext;
List<String> FULL_GENDER = UNSELECTED + GENDER;
List<String> FULL_TYPES = UNSELECTED + TYPES;
List<String> FULL_PROGRAM_TYPES = UNSELECTED + PROGRAM_TYPES;
List<String> FULL_INTERESTS = UNSELECTED + INTERESTS;
List<String> GENDER = [
  'Male 男',
  'Female 女',
];
List<String> TYPES = [
  'Academics (學術)',
  'Chats (閑聊)',
  'Food/Drinks (吃喝)',
  'Games (遊戲)',
  'Idol (偶像)',
  'Karaokes (唱歌)',
  'Meets (見面)',
  'Movies (電影)',
  'Music (音樂)',
  'Sports (運動)',
  'Others (其他)',
];

List<String> PROGRAM_TYPES = [
  'ACCT', // BBA in Professional Accounting
  'AEB', // BEng in Aerospace Engineering
  'BCBB', // BSc in Biochemistry and Cell Biology
  'BIEN', // BEng in Bioengineering
  'BIBU', // BSc in Biotechnology and Business
  'BIOT', // BSc in Biotechnology
  'CENG', // BEng in Chemical Engineering
  'CEEV', // BEng in Chemical and Environmental Engineering
  'CHEM', // BSc in Chemistry
  'CIEV', // BEng in Civil and Environmental Engineering
  'CIVL', // BEng in Civil Engineering
  'COMP', // BEng in Computer Science
  'COSC', // BSc in Computer Science
  'CPEG', // BEng in Computer Engineering
  'DAB', // BEng in Decision Analytics
  'DASC', // BSc in Data Analytics in Science
  'DSCT', // BSc in Data Science and Technology
  'ECON', // BBA in Economics
  'ECOF', // BSc in Economics and Finance
  'ELEC', // BEng in Electronic Engineering
  'EVMT', // BSc in Environmental Management and Technology
  'EXTM-AI', // Extended Major Program in Artificial Intelligence (Major+AI)
  'EXTM-DMCA', // Extended Major Program in Digital Media and Creative Arts (Major+DMCA)
  'FINA', // BBA in Finance
  'GBM', // BBA in General Business Management
  'GBUS', // BBA in Global Business
  'GCS', // BSc in Global China Studies
  'IEEM', // BEng in Industrial Engineering and Engineering Management
  'IIM', // BSc in Individualized Interdisciplinary Major
  'ISBA', // BBA in Information Systems
  'ISDN', // BSc in Integrative Systems and Design
  'MAEC', // BSc in Mathematics and Economics
  'MARK', // BBA in Marketing
  'MATH', // BSc in Mathematics
  'MECH', // BEng in Mechanical Engineering
  'MGMT', // BBA in Management
  'OM', // BBA in Operations Management
  'OST', // BSc in Ocean Science and Technology
  'PHYS', // BSc in Physics
  'QFIN', // BSc in Quantitative Finance
  'QSA', // BSc in Quantitative Social Analysis
  'RMBI', // BSc in Risk Management and Business Intelligence
  'SGFN', // BSc in Sustainable and Green Finance
  'SREQ-SBM', // School Requirements: School of Business and Management
  'SREQ-SSCI', // School Requirements: School of Science
  'SUSEE', // BEng in Sustainable Energy Engineering
  'T&M-DDP', // BEng/BSc & BBA Dual Degree Program in Technology & Management
  'WBB' // BBA in World Business
];

List<String> INTERESTS = [
  'Art 藝術',
  'Book 書',
  'Constellation 星座',
  'Cook 烹飪',
  'Dance 跳舞',
  'Game 遊戲',
  'Movie 電影',
  'Music 音樂',
  'Photography 攝影',
  'Shopping 購物',
  'Sport 運動',
  'Travel 旅行',
];
List<String> HIDDEN = [
  'HIDDEN'
];
List<String> UNSELECTED = [
  '--'
];
List<String> DNS = [
  'Do Not Show'
];
List<String> CONSTELLATIONS = [
  'Capricorn 摩羯座',
  'Aquarius 水瓶座',
  'Pisces 雙魚座',
  'Aries 牡羊座',
  'Taurus 金牛座',
  'Gemini 雙子座',
  'Cancer 巨蟹座',
  'Leo 獅子座',
  'Virgo 處女座',
  'Libra 天秤座',
  'Scorpio 天蠍座',
  'Sagittarius 射手座',
];
List<String> EVENT_TIMES = [
  'Morning',
  'Afternoon',
  'Evening',
  'Night',
  'Midnight',
  'Others',
];

// Beacon Related
// UniMatch_iBeacon_1_Visible
List<String> BEACON_ID2NAME = ['Library','LG7 Canteen'];
List<String> BEACON_ID = ['30:C6:F7:01:D2:E6','30:C6:F7:01:C7:32'];

// Not Being Used
List<String> EDU_LEVELS = [
  'Bachelor 學士',
  'Master 碩士',
  'Doctoral 博士',
  'Others',
];
List<String> MBTIS = [
  'ENFJ 主人公',
  'ENFP 競選者',
  'ENTJ 指揮官',
  'ENTP 辯論家',
  'ESFJ 執政官',
  'ESFP 表演者',
  'ESTJ 總經理',
  'ESTP 企業家',
  'INFJ 提倡者',
  'INFP 調停者',
  'INTJ 建築師',
  'INTP 邏輯學家',
  'ISFJ 守衛者',
  'ISFP 探險家',
  'ISTJ 物流師',
  'ISTP 鑒賞家',
];
List<String> PERSONALITIES = [
  'Adaptable 適應力強',
  'Adventurous 喜歡冒險',
  'Cheerful 開朗',
  'Courageous 勇敢',
  'Decisive 果斷',
  'Efficient 高效',
  'Enthusiastic 熱情',
  'Friendly 友善',
  'Hard-working 勤奮',
  'Introversion 内向',
  'Logical 理性',
  'Outgoing 外向',
  'Perfectionism 完美主義',
  'Quiet 文靜',
  'Reliable 可靠',
  'Strong 堅強',
  'Thoughtful 體貼',
];
List<String> REGIONS = [
  "Hidden",
  "Argentina",
  "Australia",
  "Austria",
  "Belarus",
  "Belgium",
  "Brazil",
  "Brunei",
  "Canada",
  "Chile",
  "China Mainland",
  "Colombia",
  "Costa Rica",
  "Croatia",
  "Cuba",
  "Czech Republic",
  "Denmark",
  "Egypt",
  "Fiji",
  "Finland",
  "France",
  "Germany",
  "Greece",
  "Guatemala",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Korea North",
  "Korea South",
  "Kuwait",
  "Lebanon",
  "Lithuania",
  "Macau",
  "Malaysia",
  "Mauritius",
  "Mexico",
  "Monaco",
  "Mongolia",
  "Morocco",
  "Myanmar",
  "Netherlands",
  "New Zealand",
  "Norway",
  "Oman",
  "Pakistan",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Qatar",
  "Romania",
  "Russian Federation",
  "Saudi Arabia",
  "Singapore",
  "South Africa",
  "Spain",
  "Sweden",
  "Switzerland",
  "Taiwan",
  "Thailand",
  "Turkey",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "Venezuela",
  "Vietnam",
  "Others",
];
List<String> RELIGIONS = [
  'Buddhism 佛教',
  'Catholic 天主教',
  'Christian 基督教',
  'Hinduism 印度教',
  'Islam 伊斯蘭教',
  'Sikhism 錫克教',
  'Taoism 道教',
  'None',
];
List<String> DISTRICTS = [
  'Central and Western 中西區',
  'Eastern 東區',
  'Islands 離島',
  'Kowloon City 九龍城',
  'Kwai Tsing 葵青',
  'Kwun Tong 觀塘',
  'North 北區',
  'Sai Kung 西貢',
  'Sha Tin 沙田',
  'Sham Shui Po 深水埗',
  'Southern 西區',
  'Tai Po 大埔',
  'Tin Shui Wai 天水圍',
  'Tsuen Wan 荃灣',
  'Tuen Mun 屯門',
  'Wan Chai 灣仔',
  'Wong Tai Sin 黃大仙',
  'Yau Tsim Mong 油尖旺',
  'Yuen Long 元朗',
];
String CONNECT = ("${string2Base64("CONNECT")}${string2Base64("accept-version:1.1,1.0")}${string2Base64("heart-beat:10000,10000")}DQoA").replaceAll("==", "0K");

var DEFAULT_PATH;
var PACKAGEINFO;
