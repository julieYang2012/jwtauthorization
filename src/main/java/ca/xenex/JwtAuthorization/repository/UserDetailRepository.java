package ca.xenex.JwtAuthorization.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import ca.xenex.JwtAuthorization.model.User;


public interface UserDetailRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String name);
}
