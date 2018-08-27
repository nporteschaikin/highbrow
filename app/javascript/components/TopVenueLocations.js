import React from "react"
import PropTypes from "prop-types"

class TopVenueLocations extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      isReady: false,
    }
  }

  componentDidMount () {
    fetch(this.props.path).
      then(response => response.json()).
      then((rows) => {
        this.setState({
          isReady: true,
          rows: rows,
        });
      });
  }

  formatLocation(row) {
    const pieces = [
      row.city,
      row.state,
      row.country_code,
    ];

    return pieces.filter(value => value).join(", ");
  }

  render () {
    if (this.state.isReady) {
      return (
        <table className="table table-bordered table-striped">
          <thead>
            <tr>
              <td>Location</td>
              <td>Venues</td>
              <td>Median rating</td>
            </tr>
          </thead>
          <tbody>
            {this.state.rows.map((row) => {
              return (
                <tr key={this.formatLocation(row)}>
                  <td>{this.formatLocation(row)}</td>
                  <td>{row.venues_count}</td>
                  <td>{row.p50_rating}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      );
    }

    return (
      <p>Loading...</p>
    );
  }
}

TopVenueLocations.propTypes = {
  path: PropTypes.string
};

export default TopVenueLocations
