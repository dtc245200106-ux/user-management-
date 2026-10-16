<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý User</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8fafc; }
        h2 { color: #1b2a7a; text-align: center; }

        /* Thanh công cụ */
        .toolbar {
            width: 80%; margin: 0 auto 15px auto;
            display: flex; flex-wrap: wrap; gap: 10px;
            justify-content: space-between; align-items: center;
        }
        .search-box { display: flex; gap: 8px; align-items: center; }
        .search-box input {
            padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; width: 220px;
        }
        .search-box button {
            padding: 8px 16px; background-color: #2980b9; color: white;
            border: none; border-radius: 4px; cursor: pointer; font-weight: bold;
        }
        .search-box button:hover { background-color: #2471a3; }

        .sort-box { display: flex; gap: 8px; align-items: center; }
        .sort-box a {
            padding: 8px 14px; border-radius: 4px; text-decoration: none;
            font-weight: bold; font-size: 14px; color: white;
        }
        .btn-sort-asc { background-color: #16a085; }
        .btn-sort-asc:hover { background-color: #138d75; }
        .btn-sort-desc { background-color: #8e44ad; }
        .btn-sort-desc:hover { background-color: #7d3c98; }
        .btn-reset { background-color: #95a5a6; }
        .btn-reset:hover { background-color: #7f8c8d; }

        /* Bảng */
        table {
            width: 80%; margin: 0 auto; border-collapse: collapse;
            background: white; box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #1b2a7a; color: white; }
        tr:hover { background-color: #f1f5f9; }

        /* Nút hành động */
        .btn {
            padding: 8px 12px; text-decoration: none; border-radius: 4px;
            color: white; font-weight: bold; font-size: 14px; display: inline-block;
        }
        .btn-add { background-color: #27ae60; }
        .btn-add:hover { background-color: #219150; }
        .btn-edit { background-color: #2980b9; margin-right: 5px; }
        .btn-edit:hover { background-color: #2471a3; }
        .btn-delete { background-color: #c0392b; }
        .btn-delete:hover { background-color: #a93226; }

        .info-bar {
            width: 80%; margin: 10px auto; padding: 8px 12px;
            background: #eaf2f8; border-left: 4px solid #2980b9;
            border-radius: 4px; color: #333; font-size: 14px;
        }
        .empty { width: 80%; margin: 30px auto; text-align: center; color: #c0392b; font-size: 18px; }
    </style>
</head>
<body>
    <h2>Danh Sách Người Dùng (Users)</h2>

    <div class="toolbar">
        <!-- Nút thêm mới -->
        <a href="${pageContext.request.contextPath}/users?action=create" class="btn btn-add">+ Thêm mới User</a>

        <!-- Tìm kiếm theo country -->
        <form action="${pageContext.request.contextPath}/users" method="GET" class="search-box">
            <input type="hidden" name="action" value="search" />
            <input type="text" name="country" placeholder="Tìm theo quốc gia..."
                   value="${requestScope.countryKeyword}" />
            <button type="submit">Tìm kiếm</button>
        </form>

        <!-- Sắp xếp theo name -->
        <div class="sort-box">
            <span style="font-weight:bold; color:#333;">Sắp xếp:</span>
            <a href="${pageContext.request.contextPath}/users?action=sort&order=asc" class="btn-sort-asc">Tên A→Z</a>
            <a href="${pageContext.request.contextPath}/users?action=sort&order=desc" class="btn-sort-desc">Tên Z→A</a>
            <a href="${pageContext.request.contextPath}/users" class="btn-reset">Mặc định</a>
        </div>
    </div>

    <!-- Hiển thị thông báo trạng thái -->
    <c:if test="${not empty requestScope.countryKeyword}">
        <div class="info-bar">
            Kết quả tìm kiếm cho quốc gia: <b>${requestScope.countryKeyword}</b>
            (tìm thấy ${requestScope.listUser.size()} kết quả)
        </div>
    </c:if>
    <c:if test="${not empty requestScope.sortOrder}">
        <div class="info-bar">
            Đang sắp xếp theo tên:
            <b>${requestScope.sortOrder == 'asc' ? 'A → Z' : 'Z → A'}</b>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty requestScope.listUser}">
            <div class="empty">Không có User nào để hiển thị!</div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên User</th>
                        <th>Email</th>
                        <th>Quốc gia</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${requestScope.listUser}">
                        <tr>
                            <td><c:out value="${user.id}" /></td>
                            <td><c:out value="${user.name}" /></td>
                            <td><c:out value="${user.email}" /></td>
                            <td><c:out value="${user.country}" /></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}" class="btn btn-edit">Sửa</a>
                                <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}" class="btn btn-delete">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>