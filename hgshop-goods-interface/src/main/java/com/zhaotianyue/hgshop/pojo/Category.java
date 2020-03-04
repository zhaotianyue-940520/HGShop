package com.zhaotianyue.hgshop.pojo;

import java.io.Serializable;


public class Category implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2969398964093500137L;
	private Integer id;	//id
	private String name;  //分类名称
	private Integer parentId;  //父分类id
	private String pash; //父分类名称
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getPash() {
		return pash;
	}
	public void setPash(String pash) {
		this.pash = pash;
	}
	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + ", parentId=" + parentId + ", pash=" + pash + "]";
	}
	public Category(Integer id, String name, Integer parentId, String pash) {
		super();
		this.id = id;
		this.name = name;
		this.parentId = parentId;
		this.pash = pash;
	}
	public Category() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Category other = (Category) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	
	
}
