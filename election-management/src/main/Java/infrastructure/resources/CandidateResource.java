package infrastructure.resources;

import api.dto.CandidateApi;
import api.dto.in.CreateCandidate;
import api.dto.in.UpdateCandidate;
import api.dto.out.Candidate;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.transaction.Transactional;
import javax.ws.rs.*;

import java.util.List;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;
import static org.jboss.resteasy.reactive.RestResponse.StatusCode.CREATED;

@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
@Path("/api/candidates")
public class CandidateResource {
    private final CandidateApi api;

    public CandidateResource(CandidateApi api) {
        this.api = api;
    }

    @POST
    @ResponseStatus(CREATED)
    @Transactional
    public void create(CreateCandidate dto) {
        api.create(dto);
    }

    @PUT
    @Path("/{id}")
    @Transactional
    public Candidate update (@PathParam("id")String id, UpdateCandidate dto){
        return api.update(id, dto);
    }
    @GET
    public List<Candidate> list(){
        return api.list();
    }
}
