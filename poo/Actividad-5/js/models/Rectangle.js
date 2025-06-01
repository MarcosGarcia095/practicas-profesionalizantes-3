export default class Rectangle {
    constructor(id, x, y, width, height, color) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.color = color;
        this.angle = 0;
        this.type = 'Rectangle';
    }

    draw(ctx) {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle);
        ctx.fillStyle = this.color;
        ctx.fillRect(-this.width / 2, -this.height / 2, this.width, this.height);
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