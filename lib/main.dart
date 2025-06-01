import 'package:flutter/material.dart';
import 'package:actividad3/pag1.dart';
import 'package:actividad3/pag_disciplina.dart';
import 'package:actividad3/pag_cursando.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sistema Acadêmico",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Menu Principal",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/logo.jpg', 
                  width: 200,
                ),
              ),

              
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 119, 119),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("CRUD Estudante"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pag1()),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),



            

            
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 137, 235, 150),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("CRUD Disciplina"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PagDisciplina()),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),

              
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 243, 129),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("Relacionamento Cursando"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PagCursando()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
