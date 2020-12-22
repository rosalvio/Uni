package proyecto;

import java.util.ArrayList;
import java.util.List;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Integer>>
{
	int vacunados = 0;
	int precio = 0; 
	// Numero de subgrupos
	int numJ = 4;
	int numA = 4;
	int numM = 5;
	
	
	
	public Objectives evaluate(ArrayList<Integer> fenotype) {
			
		//Jovenes
		List<Integer> jovenes = fenotype.subList(0, numJ);
		if(jovenes.contains(1) && jovenes.contains(2) && jovenes.contains(3)) {
			for(int i = 0; i<numJ; i++) {
				Integer aux = fenotype.get(i) - 1; // Posicion de la vacuna en el array
				precio += DatosVacunas.matrizCostes[aux][i];
				
				if(aux < DatosVacunas.NUM_VACUNAS - 1) 
					vacunados += DatosVacunas.numeroVoluntarios[i];
			}
			
		}
			
				
				
			
		//Adultos
		List<Integer> adultos = fenotype.subList(numJ, numJ + numA);
		if(adultos.contains(1) && adultos.contains(2) && adultos.contains(3)) {
			for(int i = numJ; i<numJ+numA; i++) {
				Integer aux = fenotype.get(i) - 1; // Posicion de la vacuna en el array
				precio += DatosVacunas.matrizCostes[aux][i];
				
				if(aux < DatosVacunas.NUM_VACUNAS - 1) 
					vacunados += DatosVacunas.numeroVoluntarios[i];
			}
			
		}
		
		//Mayores
		List<Integer> mayores = fenotype.subList(numJ + numA, numA + numJ + numM);
		if(mayores.contains(1) && mayores.contains(2) && mayores.contains(3)) {
			for(int i = numJ+numA; i<fenotype.size(); i++) {
				Integer aux = fenotype.get(i) - 1; // Posicion de la vacuna en el array
				precio += DatosVacunas.matrizCostes[aux][i];
				
				if(aux < DatosVacunas.NUM_VACUNAS - 1) 
					vacunados += DatosVacunas.numeroVoluntarios[i];
			}
			
		}
		
		
		Objectives objetivos = new Objectives();
		objetivos.add("Precio: ", Sign.MIN, precio);
		objetivos.add("Vacunados: ", Sign.MAX, vacunados);
		return objetivos;
	}
}
