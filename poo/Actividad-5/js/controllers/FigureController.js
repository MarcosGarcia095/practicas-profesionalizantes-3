import Rectangle from '../models/Rectangle.js';
import Circle from '../models/Circle.js';
import Triangle from '../models/Triangle.js';

export default class FigureController {
    constructor(canvas, ctx, colorInput, table, activeFigureDisplay) {
        this.canvas = canvas;
        this.ctx = ctx;
        this.colorInput = colorInput;
        this.table = table;
        this.activeFigureDisplay = activeFigureDisplay;
        this.figures = [];
        this.activeFigure = null;

        this.initKeyListener();
        this.initButtons();
    }

    addFigure(figure) {
        this.figures.push(figure);
        this.drawAll();
        this.updateTable();
    }

    drawAll() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.figures.forEach(figure => figure.draw(this.ctx));
    }

    updateTable() {
        this.table.innerHTML = '';
        this.figures.forEach((fig, index) => {
            const row = document.createElement('tr');

            const typeCell = document.createElement('td');
            typeCell.textContent = fig.type[0];
            row.appendChild(typeCell);

            const idCell = document.createElement('td');
            idCell.textContent = fig.id;
            row.appendChild(idCell);

            if (this.activeFigure === fig) {
                row.style.border = '2px solid green';
            }

            row.addEventListener('click', () => {
                this.activeFigure = fig;
                this.activeFigureDisplay.textContent = fig.id;
                this.updateTable();
            });

            this.table.appendChild(row);
        });
    }

    initKeyListener() {
        document.addEventListener('keydown', (event) => {
            if (!this.activeFigure) return;

            switch (event.key) {
                case 'ArrowUp':
                    this.handleForward();
                    break;
                case 'ArrowDown':
                    this.handleBackward();
                    break;
                case 'ArrowLeft':
                    this.handleRotateLeft();
                    break;
                case 'ArrowRight':
                    this.handleRotateRight();
                    break;
            }

            this.drawAll();
        });
    }

    handleForward() {
        const moveAmount = 5;
        this.activeFigure.move(moveAmount);
    }

    handleBackward() {
        const moveAmount = -5;
        this.activeFigure.move(moveAmount);
    }

    handleRotateLeft() {
        const rotateAmount = -Math.PI / 30;
        this.activeFigure.rotate(rotateAmount);
    }

    handleRotateRight() {
        const rotateAmount = Math.PI / 30;
        this.activeFigure.rotate(rotateAmount);
    }

    initButtons() {
        const rectButton = document.getElementById('create-rectangle');
        const circleButton = document.getElementById('create-circle');
        const triangleButton = document.getElementById('create-triangle');

        if (rectButton) {
            rectButton.addEventListener('click', () => {
                const id = prompt('Ingrese el identificador único del rectángulo:');
                const width = parseFloat(prompt('Ingrese el ancho del rectángulo:'));
                const height = parseFloat(prompt('Ingrese la altura del rectángulo:'));
                const x = parseFloat(prompt('Ingrese la coordenada X:'));
                const y = parseFloat(prompt('Ingrese la coordenada Y:'));
                const color = this.colorInput.value;

                const rect = new Rectangle(id, x, y, width, height, color);
                this.addFigure(rect);
            });
        }

        if (circleButton) {
            circleButton.addEventListener('click', () => {
                const id = prompt('Ingrese el identificador único del círculo:');
                const radius = parseFloat(prompt('Ingrese el radio del círculo:'));
                const x = parseFloat(prompt('Ingrese la coordenada X:'));
                const y = parseFloat(prompt('Ingrese la coordenada Y:'));
                const color = this.colorInput.value;

                const circle = new Circle(id, x, y, radius, color);
                this.addFigure(circle);
            });
        }

        if (triangleButton) {
            triangleButton.addEventListener('click', () => {
                const id = prompt('Ingrese el identificador único del triángulo:');
                const side = parseFloat(prompt('Ingrese el tamaño de los lados del triángulo equilátero:'));
                const x = parseFloat(prompt('Ingrese la coordenada X:'));
                const y = parseFloat(prompt('Ingrese la coordenada Y:'));
                const color = this.colorInput.value;

                const triangle = new Triangle(id, x, y, side, color);
                this.addFigure(triangle);
            });
        }
    }
}