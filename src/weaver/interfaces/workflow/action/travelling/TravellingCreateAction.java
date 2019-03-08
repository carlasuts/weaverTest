package weaver.interfaces.workflow.action.travelling;

import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class TravellingCreateAction implements Action {
    @Override
    public String execute(RequestInfo requestInfo) {


        return Action.SUCCESS;
    }
}
