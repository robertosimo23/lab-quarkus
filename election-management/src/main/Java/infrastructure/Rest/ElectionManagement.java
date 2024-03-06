package infrastructure.Rest;

import api.dto.out.Election;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.util.List;

@RegisterRestClient(configKey = "elections-management")

public interface ElectionManagement {
    @GET
    @Path("/api/elections")
    List<Election> getElections();

}
