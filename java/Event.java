/** ****************************************************************************
 * Event.java
 * Kevin Bell
 *
 * This GUI program displays medals winners.
 **************************************************************************** */
package olympics;

import java.io.Serializable;
import java.util.ArrayList;

public abstract class Event implements Serializable {

    ArrayList<Contestant> contestants = new ArrayList<>();
    String eventName;
//******************************************************************************
    //constructors

    public Event(String name) {    //this one for the hard coded events
        this.eventName = name;
    }

    public Event(String name, ArrayList<Contestant> contestants) {
        this.eventName = name;

        this.contestants = contestants;

        this.sortContestants();
    }     //end constructors
//******************************************************************************

    public ArrayList<Contestant> getContestants() {
        return contestants;
    }

    public String getName() {
        return eventName;
    }

    public void addContestant(String name, double score) {
        contestants.add(new Contestant(name, score));
    }

    public void sortContestants() {
        this.bubbleSortContestants(contestants, contestants.size());
    }

    public abstract void bubbleSortContestants(ArrayList<Contestant> contestants,
            int numContestants);
}
