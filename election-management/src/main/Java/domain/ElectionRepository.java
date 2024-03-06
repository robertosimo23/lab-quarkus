package domain;

public interface ElectionRepository {
    void submit(Election election);

    Election findById(String id);

}
