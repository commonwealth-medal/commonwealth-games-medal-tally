/** ****************************************************************************
 * TimedEvent.java
 * Kevin Bell
 *
 * This GUI program displays medals winners.
 **************************************************************************** */
package olympics;

import java.util.ArrayList;

public class TimedEvent extends Event {

    public TimedEvent(String name) {
        super(name);
    }

    public TimedEvent(String name, ArrayList<Contestant> list) {
        super(name, list);
    }     //called in super constructor

    @Override
    public void bubbleSortContestants(ArrayList<Contestant> contestants,
            int numContestants) {
        //sorts low to high
        if (numContestants == 1) {
            return;
        }
        for (int i = 0; i < numContestants - 1; i++) {
            if (contestants.get(i).getScore() > contestants.get(i + 1).getScore()) {
                Contestant temp = new Contestant(contestants.get(i).getName(),
                        contestants.get(i).getScore());
                contestants.set(i, contestants.get(i + 1));
                contestants.set(i + 1, temp);
            }
        }
        bubbleSortContestants(contestants, numContestants - 1);
    }
}
