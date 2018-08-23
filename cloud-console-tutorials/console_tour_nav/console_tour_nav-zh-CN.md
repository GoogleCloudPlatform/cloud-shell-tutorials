# Cloud Console 导览

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## 简介

本教程介绍了 Cloud Console 的核心功能，帮助您准备好在 Google Cloud Platform 上构建和管理应用。

您将了解以下概念：

  *  GCP 项目和资源
  *  资源简要概述和活动日志
  *  控制台导航和搜索
  *  用户和权限管理
  *  技术支持
  *  GCP 基于浏览器的命令行

让我们开始吧！

## 使用 GCP 资源

GCP 资源是构成所有 Google Cloud 服务的基本组成部分。资源以分层方式组织，可帮助您在 GCP 上整理您所做的工作。

项目是资源层次结构的第一级，它们包含其他低级别的资源，例如 Cloud Storage 存储分区和 Compute Engine 实例。

[详细了解 GCP 资源][gcp-resources]

### 项目导航

在 Cloud Console 中，使用[范围选择器][spotlight-project-select]可以轻松浏览您的各个 GCP 项目。切换项目可查看该项目及其所有子资源。

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud 服务导航

### 服务导航

可从[左侧导航菜单][spotlight-console-menu]中访问各项 Google Cloud 服务，这些服务按产品领域（包括大数据、计算、网络等）整理。

### 部分固定

对于定期访问的任何服务，您可将相应部分固定到导航菜单的顶部（只需将鼠标指针悬停在该部分项上，然后点击“固定”图标即可）。

打开导航菜单，然后选择**首页**继续。

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## 查看任意项目的简要概述

### 首页信息中心

首页信息中心可提供所选 GCP 项目的简要概述，其中会重点介绍关键指标、结算和其他有用信息。

### 自定义

您可以通过点击[自定义][spotlight-customize-dashboard]对您的信息中心进行自定义。此页面上的任何卡片都可以隐藏、显示和重新排序。每张卡片还包含自定义选项，通过溢出菜单（将鼠标指针悬停在相应卡片上时会显示该菜单）即可访问这些选项。

## 查看您的各项 GCP 资源中的活动

借助[活动流][spotlight-activity-stream]，您可以在一个位置了解在您的所有 GCP 资源中发生的所有活动。

看看您的团队成员正在更新哪些项目中的哪些内容，以便跟踪问题和审核访问。轻松过滤 Feed 以准确找到您所需的内容。

## 在 Cloud Console 中搜索

通过 Cloud Console 中的[搜索栏][spotlight-search-bar]，您可以快速访问 Google Cloud 产品以及您在 GCP 上的所有资源。

请尝试搜索 **App Engine** 或您的某个项目的名称。

## 随时获取支持

如果您遇到问题或者需要在 GCP 中导航方面的帮助，我们的支持团队会竭诚为您提供帮助！

[详细了解支持](http://cloud.google.com/support)

通过导航菜单获取支持。

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## 管理用户和权限

通过 Cloud Identity and Access Management (Cloud IAM)，您可以为 GCP 资源管理和创建权限。

[详细了解 IAM](https://cloud.google.com/iam/docs/)

随着您的团队不断发展壮大，您可以在“IAM 和管理”部分中使用 Cloud IAM 为团队成员授予访问权限。

添加用户、群组或服务帐号并为他们分配任意数量的角色，以便为他们授予所需的权限。

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## 通过浏览器访问命令行

Google Cloud Shell 让您可以直接在浏览器中通过命令行访问云端资源。您可以轻松管理项目和资源，而无需在系统上安装 Google Cloud SDK 或其他工具。

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud
Shell][spotlight-open-devshell] 让您可以根据自己的需要，随时使用最新且经过全面身份验证的 Cloud SDK gcloud 命令行工具以及其他必备的实用工具。

[详细了解 Cloud Shell](https://cloud.google.com/shell/)

## 继续您的 GCP 之旅

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您现在已经通过探索新服务和产品打下了扎实的基础，应该可以游刃有余地在 Cloud Console 中导航了。

我们的[详细文档](https://cloud.google.com/docs/)还提供了丰富的信息，包括产品概述和快速入门指南以及 API 参考。

请返回“使用入门”页面以查看更多教程。
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
