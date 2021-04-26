package proyecto;

import java.util.ArrayList;
import java.util.List;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Integer>>
{
	// Numero de subgrupos
	int numJ = 4;
	int numA = 4;
	int numM = 5;
	
	
	public boolean cumpleRestricciones(ArrayList<Integer> fenotype) {
		List<Integer> jovenes = fenotype.subList(0, numJ);
        List<Integer> adultos = fenotype.subList(numJ, numJ + numA);
        List<Integer> mayores = fenotype.subList(numJ + numA, fenotype.size());  
		return (jovenes.contains(1) && jovenes.contains(2)) &&
				(adultos.contains(1) && adultos.contains(2)) &&
				(mayores.contains(1) && mayores.contains(2));
		
	}
	
	
	public Objectives evaluate(ArrayList<Integer> fenotype) {
			
		
		int vacunados = 0;
		int precio = 0; 
		
		if(!cumpleRestricciones(fenotype)) {
			precio = Integer.MAX_VALUE;
			vacunados = Integer.MIN_VALUE;
		}
		else {
			for(int i = 0; i < fenotype.size(); i++) {
				int aux = fenotype.get(i) - 1; // Posicion de la vacuna en el array
				precio += DatosVacunas.matrizCostes[aux][i];
				if(aux < DatosVacunas.NUM_VACUNAS - 1) 
					vacunados += DatosVacunas.numeroVoluntarios[i];
			}
			if(fenotype.get(2) == 3 && fenotype.get(3) == 3 )
				precio-=5;
			if(fenotype.get(5) == 3 && fenotype.get(6) == 3)
				precio+=4;
		}
		
		
		Objectives objetivos = new Objectives();
		objetivos.add("Precio: ", Sign.MIN, precio);
		objetivos.add("Vacunados: ", Sign.MAX, vacunados);
		return objetivos;
	}
}
