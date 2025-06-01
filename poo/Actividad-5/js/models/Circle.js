export default class Circle {
    constructor(id, x, y, radius, color) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.color = color;
        this.angle = 0;
        this.type = 'Circle';
    }

    draw(ctx) {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle);
        ctx.beginPath();
        ctx.arc(0, 0, this.radius, 0, 2 * Math.PI);
        ctx.fillStyle = this.color;
        ctx.fill();
        ctx.restore();
    }

    move(distance) {
        this.x += distance * Math.cos(this.angle);
        this.y += distance * Math.sin(this.angle);
    }

    rotate(angle) {
        this.angle += angle;
    }
}