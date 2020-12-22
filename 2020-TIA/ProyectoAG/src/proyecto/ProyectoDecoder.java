package proyecto;


import java.util.ArrayList;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<IntegerGenotype, ArrayList<Integer>>
{
	// Que cada voluntario se asigne a un grupo
	public ArrayList<Integer> decode(IntegerGenotype genotype){
		ArrayList<Integer> fenotype = new ArrayList<Integer>();
		for(int i = 0 ; i< genotype.size(); i++) {
			fenotype.add(genotype.get(i));
		}
		return fenotype;
	}
}
