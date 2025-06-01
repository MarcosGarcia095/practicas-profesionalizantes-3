import FigureController from './controllers/FigureController.js';

const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');
const colorInput = document.getElementById('color-picker');
const table = document.getElementById('figure-table');
const activeFigureDisplay = document.getElementById('active-figure');

const controller = new FigureController(canvas, ctx, colorInput, table, activeFigureDisplay);