# MusicOL – Flutter + Firebase Architecture & Project Guide

> **Mục tiêu:** Tài liệu MD “xương sống” để khởi tạo và vận hành dự án MusicOL (web/app) viết bằng **Flutter**, dùng **Firebase** (Auth, Firestore, Storage, Cloud Functions, Remote Config, Analytics, Crashlytics, FCM). Bao gồm:
> - Kiến trúc tổng thể, quyết định công nghệ, cấu trúc thư mục.
> - Chuẩn code, quy tắc review/commit/branch, test & CI/CD.
> - Thiết kế dữ liệu (Firestore/Storage), Security Rules, Indexes.
> - Quy trình build, release, cấu hình đa môi trường.
> - Chiến lược âm thanh: phát nền, queue, tải offline.

---

## Mục lục
1. [Tầm nhìn & Phạm vi](#tầm-nhìn--phạm-vi)
2. [Kiến trúc tổng quan](#kiến-trúc-tổng-quan)
3. [Stack công nghệ](#stack-công-nghệ)
4. [Cấu trúc thư mục dự án](#cấu-trúc-thư-mục-dự-án)
5. [Quy tắc đặt tên & chuẩn code](#quy-tắc-đặt-tên--chuẩn-code)
6. [Mô hình dữ liệu Firestore](#mô-hình-dữ-liệu-firestore)
7. [Firebase Storage layout](#firebase-storage-layout)
8. [Security Rules (Firestore/Storage)](#security-rules-firestorestorage)
9. [Chỉ mục (Indexes) & Truy vấn Firestore](#chỉ-mục-indexes--truy-vấn-firestore)
10. [Luồng nghiệp vụ chính](#luồng-nghiệp-vụ-chính)
11. [State Management & Navigation](#state-management--navigation)
12. [Âm thanh: Engine, Background, Offline](#âm-thanh-engine-background-offline)
13. [Xử lý lỗi, Logging, Crash](#xử-lý-lỗi-logging-crash)
14. [Cấu hình môi trường & Secrets](#cấu-hình-môi-trường--secrets)
15. [Build, Release, Store Listing](#build-release-store-listing)
16. [Testing chiến lược](#testing-chiến-lược)
17. [Git workflow & CI/CD](#git-workflow---cicd)
18. [Analytics, Remote Config, A/B](#analytics-remote-config-ab)
19. [Hiệu năng & tối ưu](#hiệu-năng--tối-ưu)
20. [Khả năng truy cập (a11y), i18n/l10n](#khả-năng-truy-cập-a11y-i18nl10n)
21. [Checklist khởi tạo dự án](#checklist-khởi-tạo-dự-án)
22. [Phụ lục: Snippets mẫu](#phụ-lục-snippets-mẫu)

---

## Tầm nhìn & Phạm vi
- **MusicOL** là ứng dụng nghe nhạc đa nền tảng (Web, Android, iOS) với các tính năng chính:
  - Duyệt **Tracks / Albums / Artists**; tạo & quản lý **Playlists**; **Tìm kiếm** theo từ khóa & bộ lọc.
  - **Phát nhạc nền**, **hàng đợi (queue)**, **history**, **like/favorite**, bình luận (tùy chọn), tải **offline**.
  - Đăng nhập bằng Email/Password, Google; phân quyền **user / editor / admin** (custom claims).
  - Thông báo **push** (phát hành album mới, cập nhật playlist, khuyến mãi), **Analytics** cho hành vi nghe.
- **Không phạm vi (giai đoạn 1):** Livestream, social feed phức tạp, bản quyền DRM cao cấp.

---


...(toàn bộ nội dung chi tiết ở document đã tạo ở canvas)...