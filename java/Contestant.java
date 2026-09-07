/** ****************************************************************************
 * Contestant.java
 * Kevin Bell
 *
 * This GUI program displays medals winners.
 **************************************************************************** */
package olympics;

import java.io.Serializable;

public class Contestant implements Serializable {

    String name;
    double score;

    public Contestant(String name, double score) {
        this.name = name;
        this.score = score;
    }     //constructor

    public String getName() {
        return name;
    }

    public double getScore() {
        return score;
    }
}
