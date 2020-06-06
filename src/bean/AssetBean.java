package bean;

public class AssetBean {
    private String name;
    private int size;
    private String createdTime;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public AssetBean() {
        name = "";
        size = 0;
        createdTime = "";
    }
}
