/** ****************************************************************************
 * ScoredEvent.java
 * Kevin Bell
 *
 * This GUI program displays medals winners.
 **************************************************************************** */
package olympics;

import java.util.ArrayList;

public class ScoredEvent extends Event {

    public ScoredEvent(String name) {
        super(name);
    }

    public ScoredEvent(String name, ArrayList<Contestant> list) {
        super(name, list);
    }     //called in super constructor

    @Override
    public void bubbleSortContestants(ArrayList<Contestant> contestants,
            int numContestants) {
        if (numContestants == 1) {         //sorts high to low
            return;
        }
        for (int i = 0; i < numContestants - 1; i++) {
            if (contestants.get(i).getScore() < contestants.get(i + 1).getScore()) {
                Contestant temp = new Contestant(contestants.get(i).getName(),
                        contestants.get(i).getScore());

                contestants.set(i, contestants.get(i + 1));
                contestants.set(i + 1, temp);
            }
        }
        bubbleSortContestants(contestants, numContestants - 1);
    }
}
