export default class Triangle {
    constructor(id, x, y, side, color) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.side = side;
        this.color = color;
        this.angle = 0;
        this.type = 'Triangle';
    }

    draw(ctx) {
        const height = (Math.sqrt(3) / 2) * this.side;

        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle);

        ctx.beginPath();
        ctx.moveTo(0, -height / 2);
        ctx.lineTo(-this.side / 2, height / 2);
        ctx.lineTo(this.side / 2, height / 2);
        ctx.closePath();

        ctx.fillStyle = this.color;
        ctx.fill();
        ctx.restore();
    }

    move(distance) {
        this.y -= distance * Math.cos(this.angle);
        this.x += distance * Math.sin(this.angle);
    }

    rotate(angle) {
        this.angle += angle;
    }
}