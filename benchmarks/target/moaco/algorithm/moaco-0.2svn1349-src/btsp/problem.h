#ifndef PROBLEM_H
#define PROBLEM_H

/* This should be called to initialize a problem given an instance (typically,
   a filename or a label) */
problem_t * SolInitProblem(const char * instance);

/* Print a solution to stream in one line of text. */
void SolPrintOneLine(FILE *stream, const t_solution *s);
void SolPrint(FILE * stream, const t_solution *s);

void SolPrintParam(FILE *stream, const char *prefix);
void SolPrintVersion(FILE *stream, const char *prefix);

/* This is called by the algorithm to inform the problem that it is going to
   use these weights repeatedly, so that the algorithm can do any necessary
   precomputations.  */
void SolProblemSetWeights (const t_number *weights, 
                           int num_weights,
                           int **candlist,
                           int candlist_size);

t_solution *SolCreate(void);
void SolCopy(t_solution * dest, const t_solution * src);
void SolFree(t_solution * s);
void SolEvaluate (t_solution *solution);
void SolCheck (const t_solution *solution);

// for qsort() and alike
int Solcmp(const void * s1, const void * s2); // for qsort() and alike
int Solcmp_obj1(const void * s1, const void * s2);
int Solcmp_obj2(const void * s1, const void * s2);
/* Compare according to first objective, then second one.  */
int SolCompare_obj1(const t_solution * p1, const t_solution * p2);
/* Compare according to second objective, then first one.  */
int SolCompare_obj2(const t_solution * p1, const t_solution * p2);
/* Compare only according to first objective.  */
int SolCompare(const t_solution * s1, const t_solution * s2);

void SolGenerateRandom(t_solution *s);

static inline t_number 
SolGetObjective(const t_solution *s, int obj)
{
#if DEBUG > 0
    if (obj <= 0 || obj > NUM_OBJ) {
        fprintf (stderr, "%s(): objective %d does not exist!\n", __FUNCTION__,
                 obj);
        exit (EXIT_FAILURE);
    }
#endif
    return s->o[obj-1];
}

static inline void SolSetObjective(t_solution *s, int obj, t_number valor)
{
    assert (obj == 1 || obj == 2);
    s->o[obj - 1] = valor;
}

#endif
