#include <iostream>
#include <vector>
#include <cmath>
// how a mitrix is reprsented? 
// vector <vector<int>>
using namespace std;
class Matrix {
    public:
    vector <vector <int>> *mat;
    int rows,cols;

    Matrix (int rows ,int cols, int elementToFill){
        mat= new vector <vector <int>>(rows);
        for (int i=0;i<rows;i++){
            vector <int> *newRow = new vector<int>(cols,elementToFill);
            (*mat)[i]=*newRow;
        }
        this->rows = rows;
        this->cols = cols;

    }

    bool sizeMatch (const Matrix& matrix2){
        return (matrix2.rows == this->rows) && (matrix2.cols == this->cols); 
    }

    bool isSquareMatrix(){
        return (this->rows == this->cols);
    }

    Matrix operator+ (const Matrix& matrix2){
            Matrix ret (this->rows,this->cols,0);
        if (this->sizeMatch (matrix2) ) {
           
            for (int i=0;i<rows;i++)
                for (int j=0;j<cols;j++)
                    (*(ret.mat))[i][j]= (*(this->mat))[i][j]+((*matrix2.mat)[i][j]);
            return ret;
        }
        else {
            return ret;
        }
    }

    Matrix operator* (int scalerQuantity){       
        Matrix ret (this->rows,this->cols,0);
        for (int i=0;i<rows;i++)
            for (int j=0;j<cols;j++)
                (*(ret.mat))[i][j]= (*(this->mat))[i][j] * scalerQuantity;
        return ret;
    }
    Matrix operator- (Matrix& matrix2){
        return (matrix2*-1)+(*this);
    }

    void pasteSubMatrix(const Matrix& matrix2 , int posX, int posY){
        if (this->rows >= matrix2.rows && this->cols >= matrix2.cols){
            for (int i = 0 ; i < matrix2.rows ; i++){
                for (int j = 0; j< matrix2.cols ; j++){
                    (*(this->mat))[i+posY][j+posX] = ((*matrix2.mat)[i][j]) ;
                }
            }
        }
        else cout << "Error in copying" << endl;
    }

    void printMat(){
        
        for (int i=0;i<rows;i++){
            for (int j=0;j<cols;j++){
                 cout << (*(this->mat))[i][j] << ", " ;
            }
            std::cout << std::endl;
        }
    }
    Matrix multiplication_using_DC (const Matrix& matrix2){
        Matrix ret(this->rows,this->cols,0);
        if (!sizeMatch(matrix2) || !(this->isSquareMatrix()) ){
            cout << "error: size of bth matrix are not same" << endl;
            return ret;
        }
        else {
            if (this->rows == 1 && this->cols ==1){
                (*(ret.mat))[0][0] = (*(this->mat))[0][0]*((*matrix2.mat)[0][0]);
            }
            else {
               Matrix A11 (this->rows/2,this->cols/2,0); 
               Matrix A12 (this->rows/2,this->cols/2,0); 
               Matrix A21 (this->rows/2,this->cols/2,0); 
               Matrix A22 (this->rows/2,this->cols/2,0); 
               Matrix B11 (this->rows/2,this->cols/2,0); 
               Matrix B12 (this->rows/2,this->cols/2,0); 
               Matrix B21 (this->rows/2,this->cols/2,0); 
               Matrix B22 (this->rows/2,this->cols/2,0);

               for (int i=0;i<this->rows/2;i++){
                    for (int j=0;j<this->cols/2;j++){
                        (*(A11.mat))[i][j] = (*(this->mat))[i][j];
                        (*(A12.mat))[i][j] = (*(this->mat))[i][j+(this->cols/2)];
                        (*(A21.mat))[i][j] = (*(this->mat))[i+(this->rows/2)][j];
                        (*(A22.mat))[i][j] = (*(this->mat))[i+(this->rows/2)][j+(this->cols/2)];
                        
                        (*(B11.mat))[i][j] = (*(matrix2.mat))[i][j];
                        (*(B12.mat))[i][j] = (*(matrix2.mat))[i][j+(this->cols/2)];
                        (*(B21.mat))[i][j] = (*(matrix2.mat))[i+(this->rows/2)][j];
                        (*(B22.mat))[i][j] = (*(matrix2.mat))[i+(this->rows/2)][j+(this->cols/2)];
                    }
               }

               Matrix ret11 = A11.multiplication_using_DC(B11) + A12.multiplication_using_DC(B21);
               Matrix ret12 = A11.multiplication_using_DC(B12) + A12.multiplication_using_DC(B22);
               Matrix ret21 = A21.multiplication_using_DC(B11) + A22.multiplication_using_DC(B21);
               Matrix ret22 = A21.multiplication_using_DC(B12) + A22.multiplication_using_DC(B22);

               ret.pasteSubMatrix (ret11,0,0);
               ret.pasteSubMatrix (ret12,0,this->cols/2);
               ret.pasteSubMatrix (ret21,this->rows/2,0);
               ret.pasteSubMatrix (ret22,this->rows/2,this->cols/2);
            }
            return ret;
        }
    }
        


Matrix multiplication_using_Strassen (const Matrix& matrix2){
        Matrix ret(this->rows,this->cols,0);
        if (!sizeMatch(matrix2) || !(this->isSquareMatrix()) ){
            cout << "error: size of bth matrix are not same" << endl;
            return ret;
        }
        else {
            if (this->rows == 1 && this->cols ==1){
                (*(ret.mat))[0][0] = (*(this->mat))[0][0]*((*matrix2.mat)[0][0]);
            }
            else {
               Matrix A11 (this->rows/2,this->cols/2,0); 
               Matrix A12 (this->rows/2,this->cols/2,0); 
               Matrix A21 (this->rows/2,this->cols/2,0); 
               Matrix A22 (this->rows/2,this->cols/2,0); 
               Matrix B11 (this->rows/2,this->cols/2,0); 
               Matrix B12 (this->rows/2,this->cols/2,0); 
               Matrix B21 (this->rows/2,this->cols/2,0); 
               Matrix B22 (this->rows/2,this->cols/2,0);

               for (int i=0;i<this->rows/2;i++){
                    for (int j=0;j<this->cols/2;j++){
                        (*(A11.mat))[i][j] = (*(this->mat))[i][j];
                        (*(A12.mat))[i][j] = (*(this->mat))[i][j+(this->cols/2)];
                        (*(A21.mat))[i][j] = (*(this->mat))[i+(this->rows/2)][j];
                        (*(A22.mat))[i][j] = (*(this->mat))[i+(this->rows/2)][j+(this->cols/2)];
                        
                        (*(B11.mat))[i][j] = (*(matrix2.mat))[i][j];
                        (*(B12.mat))[i][j] = (*(matrix2.mat))[i][j+(this->cols/2)];
                        (*(B21.mat))[i][j] = (*(matrix2.mat))[i+(this->rows/2)][j];
                        (*(B22.mat))[i][j] = (*(matrix2.mat))[i+(this->rows/2)][j+(this->cols/2)];
                    }
               }

               Matrix r1 = (A11+A22).multiplication_using_Strassen((B11 + B22));
               Matrix r2 = (A21+A22).multiplication_using_Strassen(B11);
               Matrix r3 = (A11).multiplication_using_Strassen((B12 - B22));
               Matrix r4 = (A22).multiplication_using_Strassen((B21 - B11));
               Matrix r5 = (A11 + A12).multiplication_using_Strassen(B22);
               Matrix r6 = (A21-A11).multiplication_using_Strassen((B11 + B12));
               Matrix r7 = (A12-A22).multiplication_using_Strassen((B21 + B22));

               ret.pasteSubMatrix (r1 + r4 - r5 + r7,0,0);
               ret.pasteSubMatrix (r2 + r4,0,this->cols/2);
               ret.pasteSubMatrix (r3 + r5,this->rows/2,0);
               ret.pasteSubMatrix (r1 + r3 - r2 + r6,this->rows/2,this->cols/2);
            }
            return ret;
        }
    }
        
};
int main (){
    int size = pow(2,3);
    Matrix m (size,size,4);
    
    (m.multiplication_using_DC(m)).printMat();
    (m.multiplication_using_Strassen(m)).printMat();
    return 0;
}
