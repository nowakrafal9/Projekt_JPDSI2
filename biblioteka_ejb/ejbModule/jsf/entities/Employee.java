package jsf.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the employee database table.
 * 
 */
@Entity
@NamedQuery(name="Employee.findAll", query="SELECT e FROM Employee e")
public class Employee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idEmployee;

	private String login;

	private String name;

	private String password;

	private byte status;

	private String surname;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name="idRole")
	private Role role;

	//bi-directional many-to-one association to Bookstock
	@OneToMany(mappedBy="employee")
	private List<Bookstock> bookstocks;

	//bi-directional many-to-one association to Borrowed
	@OneToMany(mappedBy="employee")
	private List<Borrowed> borroweds;

	public Employee() {
	}

	public int getIdEmployee() {
		return this.idEmployee;
	}

	public void setIdEmployee(int idEmployee) {
		this.idEmployee = idEmployee;
	}

	public String getLogin() {
		return this.login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public byte getStatus() {
		return this.status;
	}

	public void setStatus(byte status) {
		this.status = status;
	}

	public String getSurname() {
		return this.surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<Bookstock> getBookstocks() {
		return this.bookstocks;
	}

	public void setBookstocks(List<Bookstock> bookstocks) {
		this.bookstocks = bookstocks;
	}

	public Bookstock addBookstock(Bookstock bookstock) {
		getBookstocks().add(bookstock);
		bookstock.setEmployee(this);

		return bookstock;
	}

	public Bookstock removeBookstock(Bookstock bookstock) {
		getBookstocks().remove(bookstock);
		bookstock.setEmployee(null);

		return bookstock;
	}

	public List<Borrowed> getBorroweds() {
		return this.borroweds;
	}

	public void setBorroweds(List<Borrowed> borroweds) {
		this.borroweds = borroweds;
	}

	public Borrowed addBorrowed(Borrowed borrowed) {
		getBorroweds().add(borrowed);
		borrowed.setEmployee(this);

		return borrowed;
	}

	public Borrowed removeBorrowed(Borrowed borrowed) {
		getBorroweds().remove(borrowed);
		borrowed.setEmployee(null);

		return borrowed;
	}

}