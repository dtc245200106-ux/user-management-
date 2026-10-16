package com.codegym.dao;

import com.codegym.model.User;
import java.util.List;

public interface IUserDAO {
    void insertUser(User user) throws Exception;
    User selectUser(int id);
    List<User> selectAllUsers();
    boolean deleteUser(int id) throws Exception;
    boolean updateUser(User user) throws Exception;

    // ===== MỚI THÊM =====

    /**
     * Tìm kiếm User theo country (tương đối).
     * @param country Từ khóa quốc gia
     * @return Danh sách User khớp
     */
    List<User> searchByCountry(String country);

    /**
     * Sắp xếp danh sách User theo tên.
     * @param order "asc" hoặc "desc"
     * @return Danh sách User đã sắp xếp
     */
    List<User> sortByName(String order);
}