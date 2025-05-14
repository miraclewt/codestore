/* @theme zju */

@charset "UTF-8";
@import 'uncover';
@import 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/base16/github.min.css';

:root {
    font-size: 25px;
    text-align: left;
    font-family: Arial, Helvetica, sans-serif;
    position: relative;
}

a,
h1,
h2,
h3 {
    color: #003f88;
}

h1 {
    padding: 0;
    font-size: 68px;
}

h2 {
    margin: 0;
    font-size: 50px;
    text-align: left;
}

h3 {
    font-size: 36px;
    text-align: left;
    margin-top: 5px;
    margin-bottom: 5px;
    position: relative;
    padding-left: 16px;
}

h3::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    transform: translateY(-50%);
    width: 8px;
    height: 30px;
    background-color: #003f88;
}

h5 {
    color: #595959;
    padding: 0;
    margin: 5px 0;
    font-weight: 400;
}

h6 {
    color: #595959;
    font-weight: 400;
    margin: 0 0 10px;
    text-decoration: underline;
    font-style: oblique;
}

marp-pre {
    filter: none;
}

code {
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    border-radius: 5px;
}

:root header {
    left: 0;
    top: 0;
    padding: 18px 0 12px 60px;
    width: 100%;
    background-image: none;
    /* 移除背景图片 */
    background-repeat: no-repeat;
    background-size: 100% auto;
    text-align: left;
    color: #003f88;
    /* 设置字体颜色为蓝色 */
    font-size: 60px;
    /* 增大字体大小，可根据需要调整 */
    font-weight: 800;
    text-shadow: none;
}

/* 页尾 */
:root footer {
    color: #999;
    bottom: 2px;
    font-size: 21px;
    /* 添加图片背景 */
    background-image: url('https://github.com/zhaoluting/marp-themes/blob/master/images/zju/bg.png');
    background-size: cover;
    /* 让背景图片覆盖整个元素 */
    background-position: center;
    /* 背景图片居中显示 */
    padding: 20px;
    /* 设置相对定位，为子元素的绝对定位做准备 */
    display: flex;
    /* 使用 flex 布局 */
    align-items: flex-start;
    /* 让内容垂直靠上 */
    justify-content: flex-start;
    /* 让内容水平靠左 */
}

:root footer a {
    color: #ccc;
    transition: all 0.3s;
}

:root footer a:hover {
    color: #003f88;
    text-decoration: none;
}

/* 页码 */
:root::after {
    font-size: 24px;
    font-weight: bold;
    background: none;
    /* background: none; */
    text-shadow: none;
    color: #020008;
    padding: 30px 15px 15px 30px;
    text-align: right;
}

/* 表格 */
table thead {
    background-color: #004da1;
    color: #fff;
    line-height: 50px;
}

table tbody tr {
    background-color: transparent;
    color: #595959;
}

table tbody tr:nth-of-type(2n) {
    background-color: rgba(166, 166, 166, 0.1);
}

table>tbody>tr:not(:last-child)>td {
    min-width: 140px;
    border-bottom: 1px solid #ddd;
}

/* 横向布局 */
:root.horizontalImages p {
    display: flex;
    justify-content: center;
}

/* 横向布局 */
:root.horizontalLayout {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
}

/* 首页 */
:root.homePage {
    text-align: center;
    justify-content: flex-start;
    background: #003f88;
    color: #eee;
    padding: 90px 0 0 0;
}

:root.homePage::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url("../../images/zju/cover_bg_4.jpg");
    background-size: 100% auto;
    background-position: 100% top;
    background-repeat: no-repeat;
    filter: contrast(0.3) brightness(1.7);
    z-index: -1;
    opacity: 0.8;
}

:root.homePage h1 {
    color: #fff;
    background: #003f88d8;
    line-height: 170px;
}

:root.homePage h2 {
    color: #fff;
}

/* 目录 */
:root.contents {
    text-align: center;
    color: #fff;
    padding: 0 0 0 40%;
    background-color: #003f88;
}

:root.contents::before {
    content: '';
    position: absolute;
    left: -10px;
    top: -10px;
    width: 40%;
    height: 110%;
    background-image: url("../../images/zju/left_bg_0.jpg");
    background-size: auto 100%;
    background-repeat: no-repeat;
    z-index: -1;
    border-radius: 0 55% 55% 0;
    opacity: 1;
    border: 10px solid rgb(40, 113, 196);
    border-width: 10px 50px 50px 10px;
    box-shadow: #97abd14d 5px 0px 20px 5px;
}

:root.contents h2 {
    color: #ffffffdc;
    position: relative;
    margin-bottom: 40px;
}

:root.contents h2::before {
    content: 'CONTENTS';
    position: absolute;
    bottom: -30px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 60px;
    opacity: 0.1;
    z-index: 1;
}

:root.contents ul {
    font-size: 23px;
}

:root.contents ul li {
    color: #fff;
    line-height: 40px;
    list-style: none;
    position: relative;
}

:root.contents ul li strong {
    font-size: 50px;
    line-height: 60px;
    background-image: -webkit-linear-gradient(105deg, transparent, #e7efff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-shadow: 2px 2px 20px #0000000d;
    vertical-align: middle;
    margin-right: 20px;
    /* -webkit-box-reflect: below 0 linear-gradient(transparent, rgba(0,0,0,0.4)); */
}

/* 感谢 */
:root.thanksPage {
    text-align: center;
    justify-content: flex-end;
    padding-bottom: 100px;
    background-image: url("../../images/zju/ink_bg.jpg");
    background-position: center top;
    background-repeat: no-repeat;
    background-size: 100% auto;
}

/* 内容页 */
:root.contentPage {
    background: linear-gradient(-10deg, #c5d2e3, #fff);
}

:root.contentPage img {
    margin: 5px;
}
